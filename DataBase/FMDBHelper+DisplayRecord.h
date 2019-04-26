//
//  FMDBHelper+DisplayRecord.h
//  EDA
//
//  Created by shichuang on 2016/11/1.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//  演示记录本地数据库

#import "FMDBHelper.h"
#import "DisplayRecordModel.h"

@interface FMDBHelper (DisplayRecord)

//创建演示记录数据库表
- (void)createDisplayRecordTableOnDB;

// 插入或更新演示记录
- (void)insertDisplayRecord:(DisplayRecordModel *) model;

//更新数据库数据
- (void)updateDisplayRecord:(DisplayRecordModel *) model;

//评价完成之后更新（评分）json字串
- (void)updateDisplayRecordComment:(DisplayRecordModel *)model;

//更新记录Id，服务器返回Id替换本地临时Id
- (void)updateRecordId:(NSString *)newId withOldId:(NSString *)oldId;

//更新客户Id，服务器返回Id替换本地临时Id
- (void)updateRecordsCustomerId:(NSString *)newId withOldId:(NSString *)oldId;

//删除演示记录
- (void)deleteDisplayRecord:(DisplayRecordModel *) model;

//查询数据库中是否存在某个演示记录
- (BOOL)hasDisplayRecord:(DisplayRecordModel *) model;

//更新数据库上传状态
- (void)updateDisplayRecordUplaodStaus:(DisplayRecordModel *) model;

//查询所有的演示记录
- (NSArray<DisplayRecordModel *> *)queryAllDisplayRecord;

//查询所有未确认保存记录
- (NSArray<DisplayRecordModel *> *)queryUnConfirmCoustomerDisplayRecord;

//查询客户记录列表
- (NSArray<DisplayRecordModel *> *)queryRecordsWithRecordIds:(NSString *)recordIds;

//查询所有已上传的演示记录
- (NSArray<DisplayRecordModel *> *)queryAllUploadedDisplayRecord;

//查询所有未上传的演示记录
- (NSArray<DisplayRecordModel *> *)queryAllUnUploadDisplayRecord;

//查询本月所有的演示记录
- (NSArray<DisplayRecordModel *> *)queryCurrentMonthDisplayRecordList;

//获取演示时长
- (NSString *)getDisplayTimeSumString;

//获取所有演示对象人员
//- (NSArray *)queryAllVisitCoustomer;

//清除演示记录的所有记录
- (void)deleteAllDisplayRecord;

@end
