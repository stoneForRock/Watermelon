//
//  FMDBHelper+CustomerRecords.m
//  EDA
//
//  Created by 陈逸辰 on 16/11/7.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper+CustomerRecords.h"
#import "FMDBHelper+Customer.h"


@implementation FMDBHelper (CustomerRecords)

- (void)createCustomerRecordsTableOnDB
{
    
    if([[self getDB] tableExists:DBCustomerRecordsList] == NO){
        NSString *departmentsql = @"CREATE TABLE IF NOT EXISTS %@(\
        _id INTEGER PRIMARY KEY AUTOINCREMENT,\
        customerId                      text,\
        recordIds                       text,\
        updateTimeStamp                 long,\
        UNIQUE(customerId))";
        
        departmentsql = [NSString stringWithFormat:departmentsql, DBCustomerRecordsList];
        BOOL state = [[self getDB] executeUpdate:departmentsql];
        if (!state) {
            DLog(@"error when create dbTable kDBCustomerRecordsList");
        } else {
            DLog(@"success to create dbTable kDBCustomerRecordsList");
        }
    }
}

// 插入客户记录数据
- (void)insertCustomerRecord:(CustomerRecordModel *) model
{
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(customerId,recordIds,updateTimeStamp)VALUES('%@','%@','%ld')",DBCustomerRecordsList,[model.customerId safeForFMDBString], [model.recordIds safeForFMDBString], model.updateTimeStamp];
    BOOL resSqls = [[self getDB] executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBCustomerRecordsList");
    } else {
        DLog(@"success to insert dbTable kDBCustomerRecordsList");
    }
}

//更新数据库数据
- (void)updateCustomerRecord:(CustomerRecordModel *) model
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET recordIds = '%@', updateTimeStamp = '%ld' where customerId = '%@'",DBCustomerRecordsList,[model.recordIds safeForFMDBString],model.updateTimeStamp,[model.customerId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBCustomerRecordsList");
    } else {
        DLog(@"success to update dbTable kDBCustomerRecordsList");
    }
}

//查询数据库中是否存在某个客户记录
- (BOOL)hasCustomerRecordWithCutomerId:(NSString *) customerId
{
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE customerId = '%@'",DBCustomerRecordsList,[customerId safeForFMDBString]];
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

//更新RecordId，服务器返回Id替换本地临时Id
- (void)updateCustomerRecordByCustomerId:(NSString *)newId withOldId:(NSString *)oldId
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET customerId = '%@' where customerId = '%@'",DBCustomerRecordsList,[newId safeForFMDBString],[oldId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBCustomerList");
    } else {
        DLog(@"success to update dbTable kDBCustomerList");
    }
}

//更新记录Id，服务器返回Id替换本地临时Id
- (void)updateCustomerRecordByCustomerId:(NSString *)customerId withNewRecordId:(NSString *)newRecordId withOldRecordId:(NSString *)oldRecordId
{
    CustomerRecordModel *crModel = [[FMDBHelper defaultDBHelper] queryCustomerRecordByCustomerId:customerId];
    if (crModel != nil) {
        crModel.recordIds = [crModel.recordIds stringByReplacingOccurrencesOfString:oldRecordId withString:newRecordId];
        [self updateCustomerRecord:crModel];
    }
    
}


//根据客户customerId查询记录
- (CustomerRecordModel *)queryCustomerRecordByCustomerId:(NSString *)customerId
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where customerId = '%@' ORDER BY updateTimeStamp DESC",DBCustomerRecordsList, [customerId safeForFMDBString]];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        CustomerRecordModel *model = [[CustomerRecordModel alloc] initWithFMDBSet:rs];
        return model;
    }
    return nil;
}

//查询所有有记录或者新建的客户
- (NSArray<CustomerModel *> *)queryAllRecentCustomers
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT customerId FROM %@ ORDER BY updateTimeStamp DESC",DBCustomerRecordsList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CustomerRecordModel *model = [[CustomerRecordModel alloc] initCustomerOnlyWithFMDBSet:rs];
        [groupArray addObject:model.customer];
    }
    return [groupArray copy];
}

//查询所有的客户记录
- (NSArray<CustomerRecordModel *> *)queryAllCustomerRecords
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY updateTimeStamp DESC",DBCustomerRecordsList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CustomerRecordModel *model = [[CustomerRecordModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

//删除所有客户记录
- (void)deleteAllCustomerRecords
{
    NSString *strSql = [NSString stringWithFormat:@"delete from %@",DBCustomerRecordsList];
    
    BOOL resSqls = [[self getDB] executeUpdate:strSql];
    if (!resSqls) {
        DLog(@"error when delete CustomerRecordModel from dbTable DBCustomerRecordsList");
    } else {
        DLog(@"success to delete CustomerRecordModel from dbTable DBCustomerRecordsList");
    }

}


@end
