//
//  FMDBHelper+CoustomDATag.m
//  EDA
//
//  Created by shichuang on 16/10/20.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper+CoustomDATag.h"

@implementation FMDBHelper (CoustomDATag)

#pragma mark - 创建自定义标签数据库表
- (void)createCoustomTagTableOnDB
{
    if([[self getDB] tableExists:DBCoustomTagList] == NO){
        NSString *departmentsql = @"CREATE TABLE IF NOT EXISTS %@(\
        _id INTEGER PRIMARY KEY AUTOINCREMENT,\
        coustomTagName                    text,\
        UNIQUE(coustomTagName))";
        
        departmentsql = [NSString stringWithFormat:departmentsql, DBCoustomTagList];
        BOOL state = [[self getDB] executeUpdate:departmentsql];
        if (!state) {
            DLog(@"error when create dbTable kDBCoustomTagList");
        } else {
            DLog(@"success to create dbTable kDBCoustomTagList");
        }
    }

}
// 插入自定义标签
- (void)insertCoustomTag:(NSString *) tag
{
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (coustomTagName) VALUES ('%@')",DBCoustomTagList,[tag safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBCoustomTagList");
    } else {
        DLog(@"success to insert dbTable kDBCoustomTagList");
    }
}

//更新数据库数据
- (void)updateCoustomTag:(NSString *) tag
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET coustomTagName = '%@' where coustomTagName = '%@'",DBCoustomTagList,[tag safeForFMDBString],[tag safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBCoustomTagList");
    } else {
        DLog(@"success to update dbTable kDBCoustomTagList");
    }
}

//查询数据库中是否存在某个自定义标签
- (BOOL)hasCoustomTag:(NSString *) tag
{
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE coustomTagName = '%@'",DBCoustomTagList,[tag safeForFMDBString]];
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

//删除某个自定义标签
- (void)deleteCustomTag:(NSString *) tag
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE coustomTagName = '%@'",DBCoustomTagList,[tag safeForFMDBString]];
    
    BOOL resSqls = [[self getDB] executeUpdate:sql];
    if (!resSqls) {
        DLog(@"error when delete customTag from dbTable DBCoustomTagList");
    } else {
        DLog(@"success to delete customTag from dbTable DBCoustomTagList");
    }
}

//查询所有的自定义标签
- (NSArray *)queryAllCoustomTag
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",DBCoustomTagList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        NSString *tag = [rs stringForColumn:@"coustomTagName"];
        [groupArray addObject:tag];
    }
    return [groupArray copy];
    
}

//根据标签名称数组查询自定义标签model
- (NSArray *)queryCoustomTagsWithCoustomNames:(NSArray *) coustomNames
{
    NSMutableArray *condationArray = [NSMutableArray arrayWithCapacity:0];
    
    for (NSString *customString in coustomNames)
    {
        NSArray *tagStrings = [customString componentsSeparatedByString:@"⊙"];
        for (NSString *string in tagStrings)
        {
            [condationArray addObject:[NSString stringWithFormat:@"'%@'",[string safeForFMDBString]]];
        }
        
    }
    
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE coustomTagName in (%@)",DBCoustomTagList,[condationArray componentsJoinedByString:@","]];
    
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        NSString *tag = [rs stringForColumn:@"coustomTagName"];
        [groupArray addObject:tag];
    }
    
    return [groupArray copy];
}

//删除所有自定义标签
- (void)deleteAllCoustomTag
{
    NSString *strSql = [NSString stringWithFormat:@"delete from %@",DBCoustomTagList];
    
    BOOL resSqls = [[self getDB] executeUpdate:strSql];
    if (!resSqls) {
        DLog(@"error when delete from dbTable DBCoustomTagList");
    } else {
        DLog(@"success to delete from dbTable DBCoustomTagList");
    }

}



@end
