//
//  FMDBHelper+TimeTag.m
//  EDA
//
//  Created by shichuang on 16/10/17.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper+TimeTag.h"

@implementation FMDBHelper (TimeTag)

#pragma mark - 创建时间标签数据库表
- (void)createTimeTagTableOnDB
{
    if([[self getDB] tableExists:DBTimeTagList] == NO){
        NSString *departmentsql = @"CREATE TABLE IF NOT EXISTS %@(\
        _id INTEGER PRIMARY KEY AUTOINCREMENT,\
        timeTagId                      text,\
        timeTagCompanyId               text,\
        timeTagName                    text,\
        timeTagHideType                text,\
        timeTagDesc                    text,\
        timeTagSortWeight              text,\
        UNIQUE(timeTagId))";
        
        departmentsql = [NSString stringWithFormat:departmentsql, DBTimeTagList];
        BOOL state = [[self getDB] executeUpdate:departmentsql];
        if (!state) {
            DLog(@"error when create dbTable kDBTimeTagList");
        } else {
            DLog(@"success to create dbTable kDBTimeTagList");
        }
    }
}

// 插入录model
- (void)insertTimeTag:(TimeTagModel *)model
{
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(timeTagId,timeTagCompanyId,timeTagName,timeTagHideType,timeTagDesc,timeTagSortWeight)VALUES('%@','%@','%@','%@','%@','%@')",DBTimeTagList,[model.timeTagId safeForFMDBString],[model.timeTagCompanyId safeForFMDBString],[model.timeTagName safeForFMDBString],[model.timeTagHideType safeForFMDBString],[model.timeTagDesc safeForFMDBString],[model.timeTagSortWeight safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBTimeTagList");
    } else {
        DLog(@"success to insert dbTable kDBTimeTagList");
    }
}
// 根据事务传入db,插入录model
- (void)insertTimeTag:(TimeTagModel *)model dataBase:(FMDatabase *)db
{
    if (!db) {
        [self insertTimeTag:model];
        return;
    }
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(timeTagId,timeTagCompanyId,timeTagName,timeTagHideType,timeTagDesc,timeTagSortWeight)VALUES('%@','%@','%@','%@','%@','%@')",DBTimeTagList,[model.timeTagId safeForFMDBString],[model.timeTagCompanyId safeForFMDBString],[model.timeTagName safeForFMDBString],[model.timeTagHideType safeForFMDBString],[model.timeTagDesc safeForFMDBString],[model.timeTagSortWeight safeForFMDBString]];
    BOOL resSqls = [db executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBTimeTagList");
    } else {
        DLog(@"success to insert dbTable kDBTimeTagList");
    }
}


//更新数据库数据
- (void)updateTimeTag:(TimeTagModel *) model
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET timeTagCompanyId = '%@', timeTagName = '%@',timeTagHideType = '%@' , timeTagDesc = '%@', timeTagSortWeight = '%@' where timeTagId = '%@'",DBTimeTagList,[model.timeTagCompanyId safeForFMDBString],[model.timeTagName safeForFMDBString],[model.timeTagHideType safeForFMDBString],[model.timeTagDesc safeForFMDBString],[model.timeTagSortWeight safeForFMDBString],[model.timeTagId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBTimeTagList");
    } else {
        DLog(@"success to update dbTable kDBTimeTagList");
    }
}
//根据事务传入db，更新数据库数据
- (void)updateTimeTag:(TimeTagModel *) model dataBase:(FMDatabase *)db
{
    if (!db) {
        [self updateTimeTag:model];
        return;
    }
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET timeTagCompanyId = '%@', timeTagName = '%@',timeTagHideType = '%@' , timeTagDesc = '%@', timeTagSortWeight = '%@' where timeTagId = '%@'",DBTimeTagList,[model.timeTagCompanyId safeForFMDBString],[model.timeTagName safeForFMDBString],[model.timeTagHideType safeForFMDBString],[model.timeTagDesc safeForFMDBString],[model.timeTagSortWeight safeForFMDBString],[model.timeTagId safeForFMDBString]];
    BOOL resSqls = [db executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBTimeTagList");
    } else {
        DLog(@"success to update dbTable kDBTimeTagList");
    }
}

//查询数据库中是否存在某个时长标签
- (BOOL)hasTimeTag:(NSString *) timeTagId
{
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE timeTagId = '%@'",DBTimeTagList,[timeTagId safeForFMDBString]];
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
//根据事务传入db,查询数据库中是否存在某个时长标签
- (BOOL)hasTimeTag:(NSString *) timeTagId dataBase:(FMDatabase *)db
{
    if (!db) {
        [self hasTimeTag:timeTagId];
    }
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE timeTagId = '%@'",DBTimeTagList,[timeTagId safeForFMDBString]];
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


//查询所有的时长标签
- (NSArray *)queryAllTimeTag
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE timeTagHideType = '%@'",DBTimeTagList,@"1"];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        TimeTagModel *model = [[TimeTagModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];

}

//根据时长标签数据查询所有的时长标签
- (NSArray *)queryTimeTagModelWithTimeTagNames:(NSArray *) timeTagNames
{
    NSMutableArray *condationArray = [NSMutableArray arrayWithCapacity:0];
    for (NSString *timeString in timeTagNames)
    {
        [condationArray addObject:[NSString stringWithFormat:@"'%@'",[timeString safeForFMDBString]]];
    }
    
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE timeTagName in (%@)",DBTimeTagList,[condationArray componentsJoinedByString:@","]];
    
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        TimeTagModel *model = [[TimeTagModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    return [groupArray copy];
}

//根据标签编码获取时长标签内容
- (TimeTagModel *)queryTimeTagModelByTimeTagCode:(NSString *) timeTagId
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE timeTagId =  '%@'",DBTimeTagList,[timeTagId safeForFMDBString]];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        TimeTagModel *model = [[TimeTagModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray lastObject];
}

@end
