//
//  DownloadQueueManager.m
//  EDA
//
//  Created by shichuang on 16/10/11.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "DownloadQueueManager.h"
#import "DownloadManager.h"
#import "FMDBHelper+CloudData.h"
#import "FMDBHelper+UpdateDA.h"
#import "AppDelegate.h"

#define MAX_DOWNLOADING_COUNT       1

static DownloadQueueManager *sharedDownloadQueueManager = nil;

@interface DownloadQueueManager()


@property (nonatomic, strong) NSMutableArray            *allDownLoadModel;
@property (nonatomic, strong) DownloadManager           *downloadManager;


@end

@implementation DownloadQueueManager

/** 单例 */
+ (DownloadQueueManager *)sharedDownloadQueueManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDownloadQueueManager = [[self alloc] init];
    });
    return sharedDownloadQueueManager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.allDownLoadModel = [NSMutableArray arrayWithCapacity:0];
        self.downloadManager = [[DownloadManager alloc] init];
        
        [self configurationDownloadQueue];
    }
    
    return self;
}

//判断CloudModel 是否在下载队列中如果存在就返回队列中的对象
- (DownloadBaseModel *)queryModelInDownloadQueue:(DownloadBaseModel *) model
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fileId = %@",model.fileId];
    NSArray *filterArray = [self.allDownLoadModel filteredArrayUsingPredicate:predicate];
    if (filterArray.count > 0)
    {
        return [filterArray lastObject];
    }
    else
    {
        return nil;
    }
}

//初始化下载信息
- (void)configurationDownloadQueue
{
    //获取所有未下载完成且正在下载状态的文件
    NSMutableArray *downloadingModels = [[FMDBHelper defaultDBHelper] queryDownloadingDAFile];
    
    for (CloudDataModel *downloadingModel in downloadingModels)
    {
        [self addDownLoadModel:(DownloadBaseModel *)downloadingModel];
    }
    
    //获取所有未更新完且还在更新状态的文件
    NSMutableArray *updateingModels = [[FMDBHelper defaultDBHelper] queryUpdateingDAFile];
    for (CloudDataModel *updateingModel in updateingModels)
    {
        [self addDownLoadModel:(DownloadBaseModel *)updateingModel];
    }

    //更新队列中的添加到等待下载列表里
    NSMutableArray *waitUpdateModels = [[FMDBHelper defaultDBHelper] queryWaitUpdateDAFile];
    for (CloudDataModel *waitUpdateModel in waitUpdateModels)
    {
        [self addDownLoadModel:(DownloadBaseModel *)waitUpdateModel];
    }
    
    //获取所有等待下载和已暂停状态的文件添加到等待下载列表里
    NSMutableArray *waitDownloadModels = [[FMDBHelper defaultDBHelper] queryWaitDownloadDAFile];
    
    for (CloudDataModel *waitDownloadModel in waitDownloadModels)
    {
        [self addDownLoadModel:(DownloadBaseModel *)waitDownloadModel];
    }
    
    //是否开启下载，需要根据设置中的网络环境来
    if ([AppDelegate defaultDelegate].isSuitForDownload)
    {
        [self startDownload];
    }
}


//添加新的下载
- (void)addDownLoadModel:(DownloadBaseModel *) model
{
    //开始添加下载的时候，将model添加到下载数组中  设置文件下载的时间
    model.downloadTime = [NSString stringWithFormat:@"%lld",(long long)[AllQuick getCurrentTimeInterval]];
    
    //如果不是已暂停的，需要设置为等待下载
    if (model.downloadState != StopDownload)
    {
        model.downloadState = WillDownload;//设置为等待下载
    }
    
    [self.allDownLoadModel addObject:model];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateDownloadRedDotNoti object:nil userInfo:@{@"type":@"downloading"}];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateDownloadRedDotNoti object:nil userInfo:@{@"type":@"update"}];
    
    [self startDownload];
}


//暂停下载
- (void)suspendDownloadModel:(DownloadBaseModel *) model
{
    model.downloadTime = [NSString stringWithFormat:@"%lld",(long long)[AllQuick getCurrentTimeInterval]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fileId = %@",model.fileId];
    DownloadBaseModel *opeartionModel = [[self.allDownLoadModel filteredArrayUsingPredicate:predicate] lastObject];
    
    if (opeartionModel)
    {
        if (opeartionModel.downloadState == Downloading)
        {
            model.downloadState = StopDownload;//设置为停止下载
            [model.downloadTask suspend];
            
            //开始新的下载
            [self startDownload];
        }else if (opeartionModel.downloadState == WillDownload)
        {
            model.downloadState = StopDownload;//设置为停止下载
            //开始新的下载
            [self startDownload];
        }
    }
}

//重新开始下载
- (void)restartDownloadModel:(DownloadBaseModel *) model
{
    if (model.downloadState == StopDownload)
    {
        //设置为重新开始
        model.downloadState = WillDownload;
        
        [self startDownload];
    }
}


//删除某个下载进程
- (void)deletedDownloadModel:(DownloadBaseModel *) model
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fileId = %@",model.fileId];
    DownloadBaseModel *opeartionModel = [[self.allDownLoadModel filteredArrayUsingPredicate:predicate] lastObject];
    
    model.downloadState = DownloadNone;
    
    if (opeartionModel.downloadTask)
    {
        [opeartionModel.downloadTask cancel];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^
                       {
                           [[NSFileManager defaultManager] removeItemAtPath:TEMP_PATH(model.fileId) error:nil];
                       });
    }
    
    [self.allDownLoadModel removeObject:opeartionModel];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateDownloadRedDotNoti object:nil userInfo:@{@"type":@"downloading"}];
    [[NSNotificationCenter defaultCenter] postNotificationName:kUpdateDownloadRedDotNoti object:nil userInfo:@{@"type":@"update"}];
    
    opeartionModel.downloadTask = nil;
    [self startDownload];
}

//从队列中移除下载完成的文件
- (void)removeModelFromQueue:(DownloadBaseModel *) model
{
    if (model.downloadState == DownloadComplete)
    {
        if ([self.allDownLoadModel containsObject:model])
        {
            [self.allDownLoadModel removeObject:model];
        }
    }
}

//从队列中移除队列中的所有文件（退出登录的时候，清空队列,单例无法释放）
- (void)removeAllQueueModel
{
    [self stopAllQueueModel];
    
    [self.allDownLoadModel removeAllObjects];
}

//暂停所有下载，在网络发生变化的时候
- (void)stopAllQueueModel
{
    for (DownloadBaseModel *model in self.allDownLoadModel)
    {
        model.downloadState = StopDownload;
        model.downloadTask = nil;
    }

}


- (void)removeAllDownloading
{
    for (DownloadBaseModel *downloadModel in self.allDownLoadModel)
    {
        downloadModel.downloadState = DownloadNone;
        
        if (downloadModel.downloadTask)
        {
            [downloadModel.downloadTask cancel];
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^
                           {
                               [[NSFileManager defaultManager] removeItemAtPath:TEMP_PATH(downloadModel.fileId) error:nil];
                           });
        }
        
        downloadModel.downloadTask = nil;
    }
    
    [self.allDownLoadModel removeAllObjects];
}


#pragma mrak --- 下载数据处理

- (void)startDownload
{
    //过滤下载中的数组
    NSPredicate *downloadingPredicate = [NSPredicate predicateWithFormat:@"downloadState = %d",Downloading];
    NSArray *downloadingArray = [self.allDownLoadModel filteredArrayUsingPredicate:downloadingPredicate];
    
    //过滤等待下载的数组
    NSPredicate *willDownloadPredicate = [NSPredicate predicateWithFormat:@"downloadState = %d",WillDownload];
    NSArray *willDownloadArray = [self.allDownLoadModel filteredArrayUsingPredicate:willDownloadPredicate];
    NSMutableArray *willDownloadMArray = [NSMutableArray arrayWithArray:willDownloadArray];

    //如果正在下载中的数量不够或者为0，需要从剩余的等待下载中拿时间最近的添加为下载中
    if (downloadingArray.count < MAX_DOWNLOADING_COUNT)
    {
        NSSortDescriptor *timeDesc = [NSSortDescriptor sortDescriptorWithKey:@"downloadTime" ascending:YES];
        //根据时间排序后的等待下载数组
        NSArray *sortWillDownloadArray = [willDownloadMArray sortedArrayUsingDescriptors:@[timeDesc]];
        
        if (sortWillDownloadArray.count > 0)
        {
            
            DownloadBaseModel *firstWillDownloadModel = [sortWillDownloadArray objectAtIndex:0];
            firstWillDownloadModel.downloadState = Downloading;
            
            //如果已经有下载任务 属于已暂停，需要重新开启，如果没有下载任务 需要开启新的下载任务
            if (firstWillDownloadModel.downloadTask)
            {
                [firstWillDownloadModel.downloadTask resume];
                
            }else
            {
                [self downloadModel:firstWillDownloadModel];
            }
            
        }
        
    }else
    {
        
    }
}

//获取所有下载中的个数 包含下载的和更新的
- (NSInteger)getDownloadingCount
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"downloadState <> 3"];
    NSArray *downloadingArray = [self.allDownLoadModel filteredArrayUsingPredicate:predicate];
    
    return downloadingArray.count;
}

- (void)downloadModel:(DownloadBaseModel *) model
{
   model.downloadTask = [self.downloadManager downloadfileWithDownloadBaseModel:model];
}

@end
