//
//  FMDBHelper+CustomerTag.h
//  EDA
//
//  Created by shichuang on 16/10/25.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//  客户标签数据库表

#import "FMDBHelper.h"
#import "CustomerTagModel.h"

@interface FMDBHelper (CustomerTag)

#pragma mark - 创建客户标签数据库表
- (void)createCustomerTagTableOnDB;

// 插入自定义标签
- (void)insertCustomerTag:(CustomerTagModel *) model;
// 根据事务传入db,插入自定义标签
- (void)insertCustomerTag:(CustomerTagModel *) model dataBase:(FMDatabase *)db;

//更新数据库数据
- (void)updateCustomerTag:(CustomerTagModel *) model;
//根据事务传入db，更新数据库数据
- (void)updateCustomerTag:(CustomerTagModel *) model dataBase:(FMDatabase *)db;

//更新数据库数据
- (void)updateCustomerTagId:(NSString *)newId withOldId:(NSString *)oldId;

//查询数据库中是否存在某个自定义标签
- (BOOL)hasCustomerTag:(CustomerTagModel *) model;
//根据事务传入db，查询数据库中是否存在某个自定义标签
- (BOOL)hasCustomerTag:(CustomerTagModel *) model dataBase:(FMDatabase *)db;

//查询是否有同名标签
- (BOOL)hasCustomerTagName:(NSString *)tagName;

//查询最近的标签
- (CustomerTagModel *)queryRecentCustomerTag;

//查询所有的自定义标签
- (NSArray<CustomerTagModel *> *)queryAllCustomerTag;

//模糊查询标签
- (NSArray<CustomerTagModel *> *)queryCustomerTagContains:(NSString *)tagName;

//查询所有未上传的客户
//- (NSArray<CustomerModel *> *)queryAllUnUploadCustomer;

@end
