//
//  FMDBHelper+DisplayRecord.m
//  EDA
//
//  Created by shichuang on 2016/11/1.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper+DisplayRecord.h"

@implementation FMDBHelper (DisplayRecord)

- (void)createDisplayRecordTableOnDB
{
    
    if([[self getDB] tableExists:DBDisplayRecordList] == NO){
        NSString *departmentsql = @"CREATE TABLE IF NOT EXISTS %@(\
        _id INTEGER PRIMARY KEY AUTOINCREMENT,\
        recordId                        text,\
        location                        text,\
        goodsGroupId                        text,\
        slideId                         text,\
        slideVersion                    INTEGER,\
        slideName                       text,\
        sceneTag                        text,\
        showDate                        long,\
        showAddress                     text,\
        customerId                      text,\
        customerName                    text,\
        showSecond                      text,\
        isVisit                         INTEGER,\
        visitSummary                    text,\
        appraiseJsonStr                 text,\
        hasUpload                       INTEGER,\
        uploadFaild                     INTEGER,\
        hasSaveRecord                   INTEGER,\
        uploadTime                      text,\
        DAType                          text,\
        macSize                    text,\
        hasComment                 INTEGER,\
        CAComment                   INTEGER,\
        DAComment                   INTEGER,\
        DocComment                  INTEGER,\
        recordVisitOn               INTEGER,\
        UNIQUE(recordId))";
        
        departmentsql = [NSString stringWithFormat:departmentsql, DBDisplayRecordList];
        BOOL state = [[self getDB] executeUpdate:departmentsql];
        if (!state) {
            DLog(@"error when create dbTable DBDisplayRecordList");
        } else {
            DLog(@"success to create dbTable DBDisplayRecordList");
        }
    }
}

// 插入演示记录
- (void)insertDisplayRecord:(DisplayRecordModel *) model
{
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(recordId,location,goodsGroupId,slideId,slideVersion,slideName,sceneTag,showDate,showAddress,customerId,customerName,showSecond,isVisit,visitSummary,appraiseJsonStr,hasUpload,uploadFaild,hasSaveRecord,uploadTime,DAType,macSize,hasComment,CAComment,DAComment,DocComment,recordVisitOn)VALUES('%@','%@','%@','%@','%d','%@','%@','%ld','%@','%@','%@','%@','%d','%@','%@','%d','%d','%d','%@','%@','%@','%d','%d','%d','%d','%d')",DBDisplayRecordList,[model.recordId safeForFMDBString],[model.location safeForFMDBString],[model.goodsGroupId safeForFMDBString],[model.slideId safeForFMDBString],model.slideVersion,[model.slideName safeForFMDBString],[model.sceneTag safeForFMDBString],model.showDate,[model.showAddress safeForFMDBString],[model.customerId safeForFMDBString],[model.customerName safeForFMDBString],[model.showSecond safeForFMDBString],model.isVisit,[model.visitSummary safeForFMDBString],[model.appraiseJsonStr safeForFMDBString],model.hasUpload,model.uploadFaild,model.hasSaveRecord,[model.uploadTime safeForFMDBString],[model.DAType safeForFMDBString],[model.macSize safeForFMDBString],model.hasComment,model.CAComment,model.DAComment,model.DocComment,model.recordVisitOn];
    BOOL resSqls = [[self getDB] executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable DBDisplayRecordList");
    } else {
        DLog(@"success to insert dbTable DBDisplayRecordList");
    }
}

//更新数据库数据
- (void)updateDisplayRecord:(DisplayRecordModel *) model
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET location = '%@', goodsGroupId = '%@', slideId = '%@' , slideVersion = '%d',slideName = '%@' , sceneTag = '%@', showDate = '%ld', showAddress = '%@', customerId = '%@', customerName = '%@', showSecond = '%@', isVisit = '%d', visitSummary = '%@', appraiseJsonStr = '%@', hasUpload = '%d',uploadFaild = '%d',hasSaveRecord = '%d', uploadTime = '%@', DAType = '%@', macSize = '%@', hasComment = '%d', CAComment = '%d', DAComment = '%d', DocComment = '%d', recordVisitOn = '%d' where recordId = '%@'",DBDisplayRecordList,[model.location safeForFMDBString],[model.goodsGroupId safeForFMDBString],[model.slideId safeForFMDBString],model.slideVersion,[model.slideName safeForFMDBString],[model.sceneTag safeForFMDBString],model.showDate,[model.showAddress safeForFMDBString],[model.customerId safeForFMDBString],[model.customerName safeForFMDBString],[model.showSecond safeForFMDBString],model.isVisit,[model.visitSummary safeForFMDBString],[model.appraiseJsonStr safeForFMDBString],model.hasUpload,model.uploadFaild,model.hasSaveRecord,[model.uploadTime safeForFMDBString],[model.DAType safeForFMDBString],[model.macSize safeForFMDBString], model.hasComment, model.CAComment, model.DAComment, model.DocComment,model.recordVisitOn,[model.recordId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable tb_DBDisplayRecordList");
    } else {
        DLog(@"success to update dbTable tb_DBDisplayRecordList");
    }
}

//评价完成之后更新（评分）json字串
- (void)updateDisplayRecordComment:(DisplayRecordModel *)model {
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET appraiseJsonStr = '%@' where recordId = '%@'",DBDisplayRecordList, [model.appraiseJsonStr safeForFMDBString], [model.recordId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable tb_DBDisplayRecordList111111");
    } else {
        DLog(@"success to update dbTable tb_DBDisplayRecordList2222222");
    }
}

//更新记录Id，服务器返回Id替换本地临时Id
- (void)updateRecordId:(NSString *)newId withOldId:(NSString *)oldId
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET recordId = '%@' where recordId = '%@'",DBDisplayRecordList,[newId safeForFMDBString],[oldId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBCustomerList");
    } else {
        DLog(@"success to update dbTable kDBCustomerList");
    }
}

//更新客户Id，服务器返回Id替换本地临时Id
- (void)updateRecordsCustomerId:(NSString *)newId withOldId:(NSString *)oldId
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE customerId like '%%%@%%'",DBDisplayRecordList,oldId];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        DisplayRecordModel *model = [[DisplayRecordModel alloc] initWithFMDBSet:rs];
        model.customerId = [model.customerId stringByReplacingOccurrencesOfString:oldId withString:newId];
        [self updateDisplayRecord:model];
    }
}

//删除演示记录
- (void)deleteDisplayRecord:(DisplayRecordModel *) model
{
    NSString *strSQL = [NSString stringWithFormat:@"DELETE FROM %@ where recordId = '%@'",DBDisplayRecordList,[model.recordId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update db DBDisplayRecordList");
    } else {
        DLog(@"success to update db DBDisplayRecordList");
    }
}

//查询数据库中是否存在某个演示记录
- (BOOL)hasDisplayRecord:(DisplayRecordModel *) model
{
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE recordId = '%@'",DBDisplayRecordList,[model.recordId safeForFMDBString]];
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

//更新数据库上传状态
- (void)updateDisplayRecordUplaodStaus:(DisplayRecordModel *) model
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET hasUpload = '%d', uploadTime = '%@' where recordId = %@",DBDisplayRecordList,model.hasUpload,[model.uploadTime safeForFMDBString],[model.recordId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update db DBDisplayRecordList");
    } else {
        DLog(@"success to update db DBDisplayRecordList");
    }
}

//查询未确认保存的演示记录
- (NSArray<DisplayRecordModel *> *)queryUnConfirmCoustomerDisplayRecord
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where hasSaveRecord = 0 ORDER BY showDate",DBDisplayRecordList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        DisplayRecordModel *model = [[DisplayRecordModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

//查询客户记录列表
- (NSArray<DisplayRecordModel *> *)queryRecordsWithRecordIds:(NSString *)recordIds
{
    NSMutableArray *recordListArray = @[].mutableCopy;
    
    NSArray *recordIdArray = [recordIds componentsSeparatedByString:@","];
    for (NSString *recordId in recordIdArray) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where recordId = '%@'",DBDisplayRecordList, [recordId safeForFMDBString]];
        FMResultSet *rs = [[self getDB] executeQuery:sql];
        
        while ([rs next]) {
            DisplayRecordModel *model = [[DisplayRecordModel alloc] initWithFMDBSet:rs];
            [recordListArray addObject:model];
        }
    }
    
    NSSortDescriptor *timeDesc = [NSSortDescriptor sortDescriptorWithKey:@"showDate" ascending:YES];
    //根据时间排序后的数组
    NSArray *sortArray = [recordListArray sortedArrayUsingDescriptors:@[timeDesc]];
    
    recordListArray = [NSMutableArray arrayWithArray:sortArray];
    
    return [recordListArray copy];
}

//查询所有的演示记录
- (NSArray<DisplayRecordModel *> *)queryAllDisplayRecord
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",DBDisplayRecordList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        DisplayRecordModel *model = [[DisplayRecordModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

//查询所有已上传的演示记录
- (NSArray<DisplayRecordModel *> *)queryAllUploadedDisplayRecord
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where hasUpload = '%d' order by uploadTime DESC limit 0,100",DBDisplayRecordList,YES];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        DisplayRecordModel *model = [[DisplayRecordModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

//查询所有已确认客户，并且未上传的演示记录
- (NSArray<DisplayRecordModel *> *)queryAllUnUploadDisplayRecord
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where hasUpload = '%d' AND hasSaveRecord = '%d' order by uploadTime DESC",DBDisplayRecordList,NO,YES];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        DisplayRecordModel *model = [[DisplayRecordModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

//查询本月所有的演示记录
- (NSArray<DisplayRecordModel *> *)queryCurrentMonthDisplayRecordList
{
    NSMutableArray *groupArray = @[].mutableCopy;

    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where showDate > '%.f'",DBDisplayRecordList,[AllQuick getCurrentMonthZeroTimeInterval]];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        DisplayRecordModel *model = [[DisplayRecordModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

//获取演示时长
- (NSString *)getDisplayTimeSumString
{
    NSString *sql = [NSString stringWithFormat:@"select sum(showSecond) sumValue from %@",DBDisplayRecordList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];

    NSString *sumTime = @"";
    while ([rs next])
    {
        sumTime = [rs stringForColumn:@"sumValue"];
    }

    return sumTime;
}

//获取所有演示对象人员
//- (NSArray *)queryAllVisitCoustomer
//{
//    NSMutableArray *groupArray = @[].mutableCopy;
//    
//    NSString *sql = [NSString stringWithFormat:@"SELECT distinct customerName FROM %@ WHERE customerId <> '' and customerName <> ''",DBDisplayRecordList];
//    FMResultSet *rs = [[self getDB] executeQuery:sql];
//    while ([rs next]) {
//        
//        NSString *customName = [rs stringForColumn:@"customerName"];
//        if (customName.length > 0)
//        {
//            [groupArray addObject:customName];
//        }
//        
//    }
//    
//    return groupArray;
//}

//清除演示记录的所有记录
- (void)deleteAllDisplayRecord
{
    NSString *strSql = [NSString stringWithFormat:@"delete from %@",DBDisplayRecordList];
    
    BOOL resSqls = [[self getDB] executeUpdate:strSql];
    if (!resSqls) {
        DLog(@"error when delete DisplayRecordModel from dbTable DBDisplayRecordList");
    } else {
        DLog(@"success to delete DisplayRecordModel from dbTable DBDisplayRecordList");
    }

}


@end
