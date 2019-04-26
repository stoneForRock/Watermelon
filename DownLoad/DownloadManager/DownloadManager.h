//
//  DownloadManager.h
//  EDA
//
//  Created by shichuang on 16/10/11.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "DownloadBaseModel.h"

@interface NSURLSessionTask (DownloadBaseModel)

// 为了更方便去获取，而不需要遍历，采用扩展的方式，可直接提取，提高效率
@property (nonatomic, strong) DownloadBaseModel *task_downloadModel;

@end

typedef void(^DownloadProgressBlock)(CGFloat progress,CGFloat bytesRead, CGFloat totalMBRead, CGFloat totalMBExpectedToRead);
typedef void(^DownloadSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void(^DownloadFailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface DownloadManager : NSObject

#pragma mark - 类方法


/**
 *  获取文件大小
 *
 *  @param path 本地路径
 *
 *  @return 文件大小
 */
+ (unsigned long long)fileSizeForPath:(NSString *)path;

/**
 *  获取下载好的文件
 *
 *  @param cacheName 缓存文件名
 *
 *  @return 文件
 */
+ (id)getCacheFileWithFileName:(NSString *)cacheName;

#pragma mark - 实例方法


/**
 下载文件Model

 @param downloadModel 需要下载的实体

 @return 下载的任务
 */
- (NSURLSessionDataTask *)downloadfileWithDownloadBaseModel:(DownloadBaseModel *) downloadModel;


/**
 *  获取文件大小
 *
 *  @param path 本地路径
 *
 *  @return 文件大小
 */
- (unsigned long long)fileSizeForPath:(NSString *)path;

/**
 *  获取下载好的文件
 *
 *  @param fileName 缓存文件名
 *
 *  @return 文件
 */
- (id)getCacheFileWithFileName:(NSString *) fileName;


@end
