//
//  FMDBHelper+CustomerRecords.h
//  EDA
//
//  Created by 陈逸辰 on 16/11/7.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper.h"
#import "CustomerRecordModel.h"


@interface FMDBHelper (CustomerRecords)

#pragma mark - 创建客户数据库表
- (void)createCustomerRecordsTableOnDB;

// 插入客户记录数据
- (void)insertCustomerRecord:(CustomerRecordModel *) model;

//更新数据库数据
- (void)updateCustomerRecord:(CustomerRecordModel *) model;

//查询数据库中是否存在某个客户记录
- (BOOL)hasCustomerRecordWithCutomerId:(NSString *) customerId;

//更新客户Id，服务器返回Id替换本地临时Id
- (void)updateCustomerRecordByCustomerId:(NSString *)newId withOldId:(NSString *)oldId;

//更新记录Id，服务器返回Id替换本地临时Id
- (void)updateCustomerRecordByCustomerId:(NSString *)customerId withNewRecordId:(NSString *)newRecordId withOldRecordId:(NSString *)oldRecordId;

//根据客户Id查询记录
- (CustomerRecordModel *)queryCustomerRecordByCustomerId:(NSString *)customerId;

//查询所有有记录或者新建的客户
- (NSArray<CustomerModel *> *)queryAllRecentCustomers;

//查询所有的客户记录
- (NSArray<CustomerRecordModel *> *)queryAllCustomerRecords;

//删除所有客户记录
- (void)deleteAllCustomerRecords;

@end
