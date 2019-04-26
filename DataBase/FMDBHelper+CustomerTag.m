//
//  FMDBHelper+CustomerTag.m
//  EDA
//
//  Created by shichuang on 16/10/25.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper+CustomerTag.h"

@implementation FMDBHelper (CustomerTag)

#pragma mark - 创建客户标签数据库表
- (void)createCustomerTagTableOnDB
{
    if([[self getDB] tableExists:DBCustomerTagList] == NO){
        NSString *departmentsql = @"CREATE TABLE IF NOT EXISTS %@(\
        _id INTEGER PRIMARY KEY AUTOINCREMENT,\
        customerTagId                      text,\
        customerTagType                    text,\
        customerTagCompanyId               text,\
        customerTagUserId                  text,\
        customerTagName                    text,\
        customerTagHideType                text,\
        customerTagDesc                    text,\
        customerTagWeight                  text,\
        UNIQUE(customerTagId))";
        
        departmentsql = [NSString stringWithFormat:departmentsql, DBCustomerTagList];
        BOOL state = [[self getDB] executeUpdate:departmentsql];
        if (!state) {
            DLog(@"error when create dbTable kDBCustomerTagList");
        } else {
            DLog(@"success to create dbTable kDBCustomerTagList");
        }
    }

}

// 插入自定义标签
- (void)insertCustomerTag:(CustomerTagModel *) model
{
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(customerTagId,customerTagType,customerTagCompanyId,customerTagUserId,customerTagName,customerTagHideType,customerTagDesc,customerTagWeight)VALUES('%@','%@','%@','%@','%@','%@','%@','%@')",DBCustomerTagList,[model.customerTagId safeForFMDBString],[model.customerTagType safeForFMDBString],[model.customerTagCompanyId safeForFMDBString],[model.customerTagUserId safeForFMDBString],[model.customerTagName safeForFMDBString],[model.customerTagHideType safeForFMDBString],[model.customerTagDesc safeForFMDBString],[model.customerTagWeight safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBCustomerTagList");
    } else {
        DLog(@"success to insert dbTable kDBCustomerTagList");
    }

}
// 根据事务传入db,插入自定义标签
- (void)insertCustomerTag:(CustomerTagModel *) model dataBase:(FMDatabase *)db
{
    if (!db) {
        [self insertCustomerTag:model];
        return;
    }
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(customerTagId,customerTagType,customerTagCompanyId,customerTagUserId,customerTagName,customerTagHideType,customerTagDesc,customerTagWeight)VALUES('%@','%@','%@','%@','%@','%@','%@','%@')",DBCustomerTagList,[model.customerTagId safeForFMDBString],[model.customerTagType safeForFMDBString],[model.customerTagCompanyId safeForFMDBString],[model.customerTagUserId safeForFMDBString],[model.customerTagName safeForFMDBString],[model.customerTagHideType safeForFMDBString],[model.customerTagDesc safeForFMDBString],[model.customerTagWeight safeForFMDBString]];
    BOOL resSqls = [db executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBCustomerTagList");
    } else {
        DLog(@"success to insert dbTable kDBCustomerTagList");
    }
    
}


//更新数据库数据
- (void)updateCustomerTag:(CustomerTagModel *) model
{
    
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET customerTagType = '%@',customerTagCompanyId = '%@' , customerTagUserId = '%@',customerTagName = '%@' , customerTagHideType = '%@', customerTagDesc = '%@',customerTagWeight = '%@' where customerTagId = '%@'",DBCustomerTagList,[model.customerTagType safeForFMDBString],[model.customerTagCompanyId safeForFMDBString],[model.customerTagUserId safeForFMDBString],[model.customerTagName safeForFMDBString],[model.customerTagHideType safeForFMDBString],[model.customerTagDesc safeForFMDBString],[model.customerTagWeight safeForFMDBString],[model.customerTagId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBCustomerTagList");
    } else {
        DLog(@"success to update dbTable kDBCustomerTagList");
    }
}
//根据事务传入db，更新数据库数据
- (void)updateCustomerTag:(CustomerTagModel *) model dataBase:(FMDatabase *)db
{
    if (!db) {
        [self updateCustomerTag:model];
        return;
    }
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET customerTagType = '%@',customerTagCompanyId = '%@' , customerTagUserId = '%@',customerTagName = '%@' , customerTagHideType = '%@', customerTagDesc = '%@',customerTagWeight = '%@' where customerTagId = '%@'",DBCustomerTagList,[model.customerTagType safeForFMDBString],[model.customerTagCompanyId safeForFMDBString],[model.customerTagUserId safeForFMDBString],[model.customerTagName safeForFMDBString],[model.customerTagHideType safeForFMDBString],[model.customerTagDesc safeForFMDBString],[model.customerTagWeight safeForFMDBString],[model.customerTagId safeForFMDBString]];
    BOOL resSqls = [db executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBCustomerTagList");
    } else {
        DLog(@"success to update dbTable kDBCustomerTagList");
    }
}


//更新数据库数据
- (void)updateCustomerTagId:(NSString *)newId withOldId:(NSString *)oldId;
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET customerTagId = '%@' where customerTagId = '%@'",DBCustomerTagList,newId,oldId];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBCustomerTagList");
    } else {
        DLog(@"success to update dbTable kDBCustomerTagList");
    }
}

//查询数据库中是否存在某个自定义标签
- (BOOL)hasCustomerTag:(CustomerTagModel *) model
{
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE customerTagId = '%@'",DBCustomerTagList,[model.customerTagId safeForFMDBString]];
    FMResultSet *res = [[self getDB] executeQuery:strSql];
    if (!res)
    {
        NSLog(@"NO");
    }
    
    NSDictionary *dic = nil;
    
    while ([res next])
    {
        dic = [res resultDictionary];
    }
    
    if (dic)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//根据事务传入db，查询数据库中是否存在某个自定义标签
- (BOOL)hasCustomerTag:(CustomerTagModel *) model dataBase:(FMDatabase *)db
{
    if (!db) {
        [self hasCustomerTag:model];
    }
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE customerTagId = '%@'",DBCustomerTagList,[model.customerTagId safeForFMDBString]];
    FMResultSet *res = [db executeQuery:strSql];
    if (!res)
    {
        NSLog(@"NO");
    }
    
    NSDictionary *dic = nil;
    
    while ([res next])
    {
        dic = [res resultDictionary];
    }
    
    if (dic)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


//查询是否有同名标签
- (BOOL)hasCustomerTagName:(NSString *)tagName
{
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE customerTagName = '%@'",DBCustomerTagList,[tagName safeForFMDBString]];
    FMResultSet *res = [[self getDB] executeQuery:strSql];
    if (!res)
    {
        NSLog(@"NO");
    }
    
    NSDictionary *dic = nil;
    
    while ([res next])
    {
        dic = [res resultDictionary];
    }
    
    if (dic)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//查询最近的标签
- (CustomerTagModel *)queryRecentCustomerTag
{
    CustomerTagModel *model;
    NSString *sql = [NSString stringWithFormat:@"SELECT *,max(_id) FROM %@",DBCustomerTagList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        model = [[CustomerTagModel alloc] initWithFMDBSet:rs];
    }
    return model;
}

//查询所有的自定义标签
- (NSArray<CustomerTagModel *> *)queryAllCustomerTag
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE customerTagHideType = '%@'",DBCustomerTagList,@"1"];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CustomerTagModel *model = [[CustomerTagModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

//模糊查询标签
- (NSArray<CustomerTagModel *> *)queryCustomerTagContains:(NSString *)tagName
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE customerTagName like '%%%@%%'",DBCustomerTagList,[tagName safeForFMDBString]];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CustomerTagModel *model = [[CustomerTagModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

@end
