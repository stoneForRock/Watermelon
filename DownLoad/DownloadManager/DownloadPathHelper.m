//
//  DownloadPathHelper.m
//  EDA
//
//  Created by shichuang on 16/10/11.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "DownloadPathHelper.h"
#import "ZipArchive.h"
#include <sys/param.h>
#include <sys/mount.h>

@implementation DownloadPathHelper

//根据路径创建文件并返回路径
+ (NSString *)createFolder:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if(![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if(!error)
        {
            NSLog(@"%@",[error description]);
            
        }
    }
    return path;
}

+ (unsigned long long)fileSizeForPath:(NSString *)path {
    
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

//获取手机剩余存储空间的大小
+ (long long) freeDiskSpaceInBytes
{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return freespace;
}

+ (NSString *)getFileSizeString:(NSString *)size
{
    if([size floatValue]>=1024*1024)//大于1M，则转化成M单位的字符串
    {
        return [NSString stringWithFormat:@"%1.2fM",[size floatValue]/1024/1024];
    }
    else if([size floatValue]>=1024&&[size floatValue]<1024*1024) //不到1M,但是超过了1KB，则转化成KB单位
    {
        return [NSString stringWithFormat:@"%1.2fK",[size floatValue]/1024];
    }
    else//剩下的都是小于1K的，则转化成B单位
    {
        return [NSString stringWithFormat:@"%1.2fB",[size floatValue]];
    }
}

+ (float)getFileSizeNumber:(NSString *)size
{
    NSInteger indexM=[size rangeOfString:@"M"].location;
    NSInteger indexK=[size rangeOfString:@"K"].location;
    NSInteger indexB=[size rangeOfString:@"B"].location;
    if(indexM<1000)//是M单位的字符串
    {
        return [[size substringToIndex:indexM] floatValue]*1024*1024;
    }
    else if(indexK<1000)//是K单位的字符串
    {
        return [[size substringToIndex:indexK] floatValue]*1024;
    }
    else if(indexB<1000)//是B单位的字符串
    {
        return [[size substringToIndex:indexB] floatValue];
    }
    else//没有任何单位的数字字符串
    {
        return [size floatValue];
    }
}

//遍历文件夹获得文件夹大小，返回多少M
+ (float) folderSizeAtPath:(NSString*) folderPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeForPath:fileAbsolutePath];
    }
    return folderSize;
}

//删除文件夹下的所有文件
+ (void)removeAllFileAtPath:(NSString *) folderPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:folderPath error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    
    while ((filename = [e nextObject]))
    {
        [fileManager removeItemAtPath:[folderPath stringByAppendingPathComponent:filename] error:NULL];
    }
}

+ (void)unZipFile:(NSString *) fileName callBack:(void(^)(BOOL finish)) block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        ZipArchive *archive = [[ZipArchive alloc] init];
        NSString *fileZipName = [NSString stringWithFormat:@"%@.zip",fileName];
        if ([archive UnzipOpenFile:ZIP_PATH(fileZipName)])
        {
            BOOL ret = [archive UnzipFileTo:UNZIP_PATH(fileName) overWrite:YES];
            [archive UnzipCloseFile];
             dispatch_async(dispatch_get_main_queue(), ^{
                 block(ret);
             });
            
        }else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
            block(NO);
            });
        }
        
    });
    
}

//根据离职员工id删除对应缓存的文件
+ (void)deleteCachesFileWithFiredEmployeeIds:(NSArray *) firedEmployeeIds
{
    for (NSString *employeeId in firedEmployeeIds)
    {
        NSString *dbPath = [NSString stringWithFormat:@"%@/%@",CACHES_DIRECTORY,employeeId];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:dbPath error:NULL];
    }
}

//获取目前设备中包含的所有有文件的用户职员id集合
+ (NSArray<NSString *> *)getCurrentDeviceFilePathUsers
{
    NSString *dbPath = CACHES_DIRECTORY;
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:dbPath]) return @[];
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:dbPath] objectEnumerator];
    
    NSString* fileName;
    
    NSMutableArray *employeeIds = @[].mutableCopy;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil)
    {
        if (fileName.length > 0 && ![fileName isEqualToString:@"com.dachen.EDA"] && ![fileName isEqualToString:@"default"])
        {
            [employeeIds addObject:fileName];
        }
    }
    
    return employeeIds.copy;
    
    
    return @[];
}

+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *) filePathString;
{
    NSURL* URL= [NSURL fileURLWithPath: filePathString];
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

@end
