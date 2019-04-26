//
//  FMDBHelper+UpdateDA.h
//  EDA
//
//  Created by shichuang on 2016/11/11.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper.h"
#import "CloudDataModel.h"


@interface FMDBHelper (UpdateDA)


#pragma mark - 创建更新文件数据库表
- (void)createUpdateFileTableOnDB;

// 插入更新文件数据   当开始点击下载时就会插入数据库
- (void)insertUpdateCloudData:(CloudDataModel *)model;
// 根据事务传入db,插入更新文件数据   当开始点击下载时就会插入数据库
- (void)insertUpdateCloudData:(CloudDataModel *)model dataBase:(FMDatabase *)db;

//更新文件状态
- (void)updateCloudDataStateWithUpdateCloudData:(CloudDataModel *) model;

//删除某条更新数据
- (void)deleteUpdateCloudData:(CloudDataModel *) model;

//查询更新数据库中是否存在某个文件
- (BOOL)hasUpdateDownloadFile:(NSString *) fileId;

//根据已下载数据库文件id获取更新数据库中的更新信息model用来更新
- (CloudDataModel *)getUpdateModelWithFileId:(NSString *) fileId;

//删除更新资料库的所有数据
- (void)deleteAllUpdateCloudData;

//查询未下载完成为正在下载状态的所有文件
- (NSMutableArray *)queryUpdateingDAFile;

//查询所有在下载队列中的所有文件
- (NSArray *)queryUpdatedQueueListModel;

//查询正在等待下载的所有文件
- (NSMutableArray *)queryWaitUpdateDAFile;

//查询未开始下载的更新文件
- (NSMutableArray *)queryUpdateNoDownloadDAFile;

//判断某个文件是否未开始下载
- (BOOL)hasUpdateDownloadingFile:(NSString *) fileId;

@end
