//
//  DownloadQueueManager.h
//  EDA
//
//  Created by shichuang on 16/10/11.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//  下载顺序的控制类

#import <Foundation/Foundation.h>
#import "DownloadBaseModel.h"

@interface DownloadQueueManager : NSObject

/** 单例 */
+ (DownloadQueueManager *)sharedDownloadQueueManager;

//初始化下载信息
- (void)configurationDownloadQueue;

//判断CloudModel 是否在下载队列中如果存在就返回队列中的对象
- (DownloadBaseModel *)queryModelInDownloadQueue:(DownloadBaseModel *) model;

//添加新的下载
- (void)addDownLoadModel:(DownloadBaseModel *) model;

//暂停下载
- (void)suspendDownloadModel:(DownloadBaseModel *) model;

//重新开始下载
- (void)restartDownloadModel:(DownloadBaseModel *) model;

//删除某个下载进程
- (void)deletedDownloadModel:(DownloadBaseModel *) model;

//从队列中移除下载完成的文件
- (void)removeModelFromQueue:(DownloadBaseModel *) model;

//从队列中移除队列中的所有文件（退出登录的时候，清空队列,单例无法释放）
- (void)removeAllQueueModel;

//暂停所有下载，在网络发生变化的时候
- (void)stopAllQueueModel;

//移除所有的下载中文件
- (void)removeAllDownloading;

//开始下载队列  为了切换网络环境时，启动下载队列，一般对于单个文件的操作不调用
- (void)startDownload;

//获取所有下载中的个数 包含下载的和更新的
- (NSInteger)getDownloadingCount;

@end
