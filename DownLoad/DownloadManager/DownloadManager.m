//
//  DownloadManager.m
//  EDA
//
//  Created by shichuang on 16/10/11.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "DownloadManager.h"
#import <objc/runtime.h>
#import "DownloadQueueManager.h"
#import "FMDBHelper+CloudData.h"

@interface DownloadManager ()<NSURLSessionDelegate>

@end

@implementation DownloadManager

#pragma mark - 类方法

+ (unsigned long long)fileSizeForPath:(NSString *)path {
    
    return [[self alloc] fileSizeForPath:path];
}

+ (id)getCacheFileWithFileName:(NSString *)fileName
{
    return [[self alloc] getCacheFileWithFileName:fileName];
}

#pragma mark - 实例方法

- (unsigned long long)fileSizeForPath:(NSString *)path {
    
    signed long long fileSize = 0;
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    if ([fileManager fileExistsAtPath:path]) {
        
        NSError *error = nil;
        
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        
        if (!error && fileDict) {
            
            fileSize = [fileDict fileSize];
        }
    }
    
    return fileSize;
}

- (NSURLSessionDataTask *)downloadfileWithDownloadBaseModel:(DownloadBaseModel *) downloadModel
{
    
    //创建临时文件缓存目录
    [self createCacheDirectory];
    
    // 下载文件本地临时文件夹
    NSString *filePath = TEMP_PATH(downloadModel.fileId);
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    
    // 创建流
    downloadModel.stream = [NSOutputStream outputStreamToFileAtPath:filePath append:YES];
    
    // 创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:downloadModel.fileURL]];
    
    // 设置请求头 已下载长度
    unsigned long long downloadedBytes = 0;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        // 获取已下载的文件长度
        downloadedBytes = [self fileSizeForPath:filePath];
        
        // 检查文件是否已经下载了一部分
        if (downloadedBytes > 0) {
            
            NSMutableURLRequest *mutableURLRequest = [request mutableCopy];
            NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
            [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
            request = mutableURLRequest;
        }
    }
    
    // 创建一个Data任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
    task.task_downloadModel = downloadModel;
    
    //开始任务
    [task resume];
    
    //将该任务返回给model方便暂停等操作
    return task;
}

/**
 *  创建缓存目录文件
 */
- (void)createCacheDirectory
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:TEMP_FOLDER isDirectory:&isDir];
    
    if (!(isDir == YES && existed == YES)) {
        
        [fileManager createDirectoryAtPath:TEMP_FOLDER withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

#pragma mark -- taskDelegate
#pragma mark - 代理
#pragma mark NSURLSessionDataDelegate
/**
 * 接收到响应
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    
    DownloadBaseModel *sessionModel = dataTask.task_downloadModel;
    
    // 打开流
    [sessionModel.stream open];
    
    // 获得服务器这次请求 返回数据的总长度
    NSInteger totalLength = [response.allHeaderFields[@"Content-Length"] integerValue] + [self fileSizeForPath:TEMP_PATH(sessionModel.fileId)];
    sessionModel.fileSize = [NSString stringWithFormat:@"%lld",(long long)totalLength];
    
//    //数据库更新文件总大小
//    [[FMDBHelper defaultDBHelper] updateCloudDataInfoWithCloudData:(CloudDataModel *)sessionModel];
    
    // 接收这个请求，允许接收服务器的数据
    completionHandler(NSURLSessionResponseAllow);
}

/**
 * 接收到服务器返回的数据
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    DownloadBaseModel *sessionModel = dataTask.task_downloadModel;
    
    if (!sessionModel)
    {
        return;
    }
    
    // 写入数据
    [sessionModel.stream write:data.bytes maxLength:data.length];
    
    // 下载进度
    NSUInteger receivedSize = [self fileSizeForPath:TEMP_PATH(sessionModel.fileId)];
    NSUInteger expectedSize = [sessionModel.fileSize integerValue];
    CGFloat progress = 1.0 * receivedSize / expectedSize;
    
    //计算即时速度
    sessionModel.speedTotalBytes += data.length;
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    
    if (!sessionModel.speedTime)
    {
        sessionModel.speedTime = currentDate;
    }
    
    //当前时间和上一秒时间做对比，大于等于一秒就去计算
    if ([currentDate timeIntervalSinceDate:sessionModel.speedTime] >= 1) {
        //时间差
        double time = [currentDate timeIntervalSinceDate:sessionModel.speedTime];
        //计算速度
        long long speed = sessionModel.speedTotalBytes/time;
        //把速度转成KB或M
        sessionModel.speedString = [NSString stringWithFormat:@"%@/s",[DownloadPathHelper getFileSizeString:[NSString stringWithFormat:@"%lld",speed]]];
        //维护变量，将计算过的清零
        sessionModel.speedTotalBytes = 0.0;
        //维护变量，记录这次计算的时间
        sessionModel.speedTime = currentDate;
    }

    
    dispatch_async(dispatch_get_main_queue(), ^{
        sessionModel.downloadProgress = progress;
    });
    
}

/**
 * 请求完毕（成功|失败）
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    DownloadBaseModel *sessionModel = task.task_downloadModel;
    if (!sessionModel) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([self isCompletion:sessionModel])
        {
            NSString *fileZipName = [NSString stringWithFormat:@"%@.zip",sessionModel.fileId];
            //下载完成后
            NSError *error;
            //如果zip文件夹下已存在该文件 先移除
            if ([[NSFileManager defaultManager] fileExistsAtPath:ZIP_PATH(fileZipName)])
            {
                [[NSFileManager defaultManager] removeItemAtPath:ZIP_PATH(fileZipName) error:&error];
            }
            
            //将文件从临时文件中移到zip文件夹下
            if ([[NSFileManager defaultManager] moveItemAtPath:TEMP_PATH(sessionModel.fileId) toPath:ZIP_PATH(fileZipName) error:&error])
            {
                if ([sessionModel.fileSize intValue] == 0)
                {
                    // 下载失败
                    sessionModel.downloadState = StopDownload;
                    
                }else
                {
                    sessionModel.downloadState = DownloadComplete;
                    
                    //从下载队列中移除
                    [[DownloadQueueManager sharedDownloadQueueManager] removeModelFromQueue:sessionModel];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateDownloadRedDotNoti object:nil userInfo:@{@"type":@"downloaded"}];
                }
                
                
            }else
            {
                // 下载失败
                sessionModel.downloadState = StopDownload;
                
            }
            
        } else if (error){
            
            //被取消
            if (error.code == -999)
            {
                sessionModel.downloadState = DownloadNone;
                
            }else
            {
                // 下载失败
                sessionModel.downloadState = StopDownload;
            }
            
        }else
        {
            //未开始下载未知错误
            sessionModel.downloadState = StopDownload;
        }
        
        [[DownloadQueueManager sharedDownloadQueueManager] startDownload];
    });

    // 关闭流
    [sessionModel.stream close];
    sessionModel.stream = nil;
    
    // 清除任务
    sessionModel.downloadTask = nil;
}

/**
 *  判断该文件是否下载完成
 */
- (BOOL)isCompletion:(DownloadBaseModel *) downloadModel
{
    if ([downloadModel.fileSize integerValue] && [self fileSizeForPath:TEMP_PATH(downloadModel.fileId)] == [downloadModel.fileSize integerValue]) {
        return YES;
    }
    return NO;
}


- (id)getCacheFileWithFileName:(NSString *) fileName
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = UNZIP_PATH(fileName);
    NSData *data = nil;
    if([fileManager fileExistsAtPath:filePath])
        data=[NSData dataWithContentsOfFile:filePath];
    return data;
}


@end

static const void *task_downloadModelKey = "task_downloadModelKey";

@implementation NSURLSessionTask (DownloadBaseModel)

- (void)setTask_downloadModel:(DownloadBaseModel *)task_downloadModel {
    objc_setAssociatedObject(self, task_downloadModelKey, task_downloadModel, OBJC_ASSOCIATION_ASSIGN);
}

- (DownloadBaseModel *)task_downloadModel {
    return objc_getAssociatedObject(self, task_downloadModelKey);
}

@end
