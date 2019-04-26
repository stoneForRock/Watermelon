//
//  FMDBHelper+SceneTag.m
//  EDA
//
//  Created by shichuang on 16/10/17.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper+SceneTag.h"

@implementation FMDBHelper (SceneTag)

#pragma mark - 创建场景标签数据库表
- (void)createSceneTagTableOnDB
{
    if([[self getDB] tableExists:DBSceneTagList] == NO){
        NSString *departmentsql = @"CREATE TABLE IF NOT EXISTS %@(\
        _id INTEGER PRIMARY KEY AUTOINCREMENT,\
        sceneTagId                      text,\
        sceneTagCompanyId               text,\
        sceneTagCode                    text,\
        sceneTagName                    text,\
        sceneTagHideType                text,\
        sceneTagDesc                    text,\
        sceneTagSortWeight              text,\
        sceneTagGroupId                 text,\
        sceneTagGroupName               text,\
        sceneTagGroupDesc               text,\
        sceneTagGroupWeight             text,\
        UNIQUE(sceneTagId))";
        
        departmentsql = [NSString stringWithFormat:departmentsql, DBSceneTagList];
        BOOL state = [[self getDB] executeUpdate:departmentsql];
        if (!state) {
            DLog(@"error when create dbTable DBSceneTagList");
        } else {
            DLog(@"success to create dbTable DBSceneTagList");
        }
    }
}

// 插入文件夹目录model
- (void)insertSceneTag:(SceneTagModel *)model
{
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(sceneTagId,sceneTagGroupId,sceneTagCompanyId,sceneTagCode,sceneTagName,sceneTagHideType,sceneTagDesc,sceneTagSortWeight,sceneTagGroupName,sceneTagGroupDesc,sceneTagGroupWeight)VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",DBSceneTagList,[model.sceneTagId safeForFMDBString],[model.sceneTagGroupId safeForFMDBString],[model.sceneTagCompanyId safeForFMDBString],[model.sceneTagCode safeForFMDBString],[model.sceneTagName safeForFMDBString],[model.sceneTagHideType safeForFMDBString],[model.sceneTagDesc safeForFMDBString],[model.sceneTagSortWeight safeForFMDBString],[model.sceneTagGroupName safeForFMDBString],[model.sceneTagGroupDesc safeForFMDBString],[model.sceneTagGroupWeight safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBSceneTagList");
    } else {
        DLog(@"success to insert dbTable kDBSceneTagList");
    }
}
//根据事务传入db 插入文件夹目录model
- (void)insertSceneTag:(SceneTagModel *)model dataBase:(FMDatabase *)db
{
    if (!db) {
        [self insertSceneTag:model];
        return;
    }
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(sceneTagId,sceneTagGroupId,sceneTagCompanyId,sceneTagCode,sceneTagName,sceneTagHideType,sceneTagDesc,sceneTagSortWeight,sceneTagGroupName,sceneTagGroupDesc,sceneTagGroupWeight)VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",DBSceneTagList,[model.sceneTagId safeForFMDBString],[model.sceneTagGroupId safeForFMDBString],[model.sceneTagCompanyId safeForFMDBString],[model.sceneTagCode safeForFMDBString],[model.sceneTagName safeForFMDBString],[model.sceneTagHideType safeForFMDBString],[model.sceneTagDesc safeForFMDBString],[model.sceneTagSortWeight safeForFMDBString],[model.sceneTagGroupName safeForFMDBString],[model.sceneTagGroupDesc safeForFMDBString],[model.sceneTagGroupWeight safeForFMDBString]];
    BOOL resSqls = [db executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBSceneTagList");
    } else {
        DLog(@"success to insert dbTable kDBSceneTagList");
    }
}


//更新数据库数据
- (void)updateSceneTag:(SceneTagModel *) model
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET sceneTagGroupId = '%@', sceneTagCompanyId = '%@',sceneTagCode = '%@' , sceneTagName = '%@',sceneTagHideType = '%@' , sceneTagDesc = '%@', sceneTagSortWeight = '%@',sceneTagGroupName = '%@' , sceneTagGroupDesc = '%@', sceneTagGroupWeight = '%@' where sceneTagId = '%@'",DBSceneTagList,[model.sceneTagGroupId safeForFMDBString],[model.sceneTagCompanyId safeForFMDBString],[model.sceneTagCode safeForFMDBString],[model.sceneTagName safeForFMDBString],[model.sceneTagHideType safeForFMDBString],[model.sceneTagDesc safeForFMDBString],[model.sceneTagSortWeight safeForFMDBString],[model.sceneTagGroupName safeForFMDBString],[model.sceneTagGroupDesc safeForFMDBString],[model.sceneTagGroupWeight safeForFMDBString],[model.sceneTagId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBSceneTagList");
    } else {
        DLog(@"success to update dbTable kDBSceneTagList");
    }
}
//根据事务传入db 更新数据库数据
- (void)updateSceneTag:(SceneTagModel *) model dataBase:(FMDatabase *)db
{
    if (!db) {
        [self updateSceneTag:model];
        return;
    }
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET sceneTagGroupId = '%@', sceneTagCompanyId = '%@',sceneTagCode = '%@' , sceneTagName = '%@',sceneTagHideType = '%@' , sceneTagDesc = '%@', sceneTagSortWeight = '%@',sceneTagGroupName = '%@' , sceneTagGroupDesc = '%@', sceneTagGroupWeight = '%@' where sceneTagId = '%@'",DBSceneTagList,[model.sceneTagGroupId safeForFMDBString],[model.sceneTagCompanyId safeForFMDBString],[model.sceneTagCode safeForFMDBString],[model.sceneTagName safeForFMDBString],[model.sceneTagHideType safeForFMDBString],[model.sceneTagDesc safeForFMDBString],[model.sceneTagSortWeight safeForFMDBString],[model.sceneTagGroupName safeForFMDBString],[model.sceneTagGroupDesc safeForFMDBString],[model.sceneTagGroupWeight safeForFMDBString],[model.sceneTagId safeForFMDBString]];
    BOOL resSqls = [db executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBSceneTagList");
    } else {
        DLog(@"success to update dbTable kDBSceneTagList");
    }
}


//查询数据库中是否存在某个场景标签
- (BOOL)hasSceneTag:(NSString *) sceneTagId
{
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE sceneTagId = '%@'",DBSceneTagList,[sceneTagId safeForFMDBString]];
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

//传入事务db 查询数据库中是否存在某个场景标签
- (BOOL)hasSceneTag:(NSString *)sceneTagId dataBase:(FMDatabase *)db
{
    if (!db) {
        [self hasSceneTag:sceneTagId];
    }
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE sceneTagId = '%@'",DBSceneTagList,[sceneTagId safeForFMDBString]];
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



//查询所有的场景标签
- (NSArray *)queryAllSceneTag
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE sceneTagHideType = '%@'",DBSceneTagList,@"1"];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        SceneTagModel *model = [[SceneTagModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

//根据场景名称获取场景组model
- (SceneTagModel *)querySceneModelWithSceneName:(NSString *) sceneName
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE sceneTagName = '%@' AND sceneTagHideType = '%@'",DBSceneTagList,[sceneName safeForFMDBString],@"1"];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        SceneTagModel *model = [[SceneTagModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [[groupArray copy] lastObject];
}

//根据场景组id获取所有场景标签
- (NSArray *)querySceneTagByGroupId:(NSString *) groupId
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE sceneTagGroupId = '%@' AND sceneTagHideType = '%@'",DBSceneTagList,[groupId safeForFMDBString],@"1"];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        SceneTagModel *model = [[SceneTagModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

//根据场景组id和已存在的标签名称来获取场景标签
- (NSArray *)querySceneTagModelWithGroupId:(NSString *) groupId sceneNames:(NSArray *) sceneNames
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE sceneTagGroupId = '%@' AND sceneTagHideType = '%@'",DBSceneTagList,[groupId safeForFMDBString],@"1"];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        SceneTagModel *model = [[SceneTagModel alloc] initWithFMDBSet:rs];
        if ([sceneNames containsObject:model.sceneTagName])
        {
            [groupArray addObject:model];
        }
    }
    return [groupArray copy];
}

//根据标签编码获取标签内容
- (SceneTagModel *)querySceneTagModelBySceneTagCode:(NSString *) sceneTagId
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE sceneTagId =  '%@'",DBSceneTagList,[sceneTagId safeForFMDBString]];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        SceneTagModel *model = [[SceneTagModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray lastObject];
}

//获取所有场景组信息
- (NSArray<NSDictionary *> *)quertAllSceneGroup
{
    NSMutableArray *groupArray = @[].mutableCopy;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT distinct sceneTagGroupId, sceneTagGroupName FROM %@",DBSceneTagList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        NSMutableDictionary *groupInfoDic = [NSMutableDictionary dictionaryWithCapacity:0];
        [groupInfoDic setObject:[rs stringForColumn:@"sceneTagGroupId"] forKey:@"sceneGroupId"];
        [groupInfoDic setObject:[rs stringForColumn:@"sceneTagGroupName"] forKey:@"sceneGroupName"];
        [groupArray addObject:groupInfoDic];
    }
    
    return [groupArray copy];
}

//根据场景名称查询所有场景组
- (NSArray<NSDictionary *>  *)querySceneGroupWithSceneNames:(NSArray *) sceneNames
{
    NSMutableArray *condationArray = [NSMutableArray arrayWithCapacity:0];
    
    NSMutableArray *sceneTagSqls = [NSMutableArray arrayWithCapacity:0];
    for (NSString *sceneString in sceneNames)
    {
        if (sceneString)
        {
            [sceneTagSqls addObject:[NSString stringWithFormat:@"sceneTagName LIKE '%%,%@'",[sceneString safeForFMDBString]]];
            [sceneTagSqls addObject:[NSString stringWithFormat:@"sceneTagName LIKE '%@,%%'",[sceneString safeForFMDBString]]];
            [sceneTagSqls addObject:[NSString stringWithFormat:@"sceneTagName LIKE '%%,%@,%%'",[sceneString safeForFMDBString]]];
            [sceneTagSqls addObject:[NSString stringWithFormat:@"sceneTagName = '%@'",[sceneString safeForFMDBString]]];
        }
    }
    
    if (sceneTagSqls.count > 0)
    {
        [condationArray addObject:[NSString stringWithFormat:@"(%@)",[sceneTagSqls componentsJoinedByString:@" OR "]]];
    }
    
    NSMutableArray *groupArray = @[].mutableCopy;

    if (condationArray.count > 0)
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT distinct sceneTagGroupId, sceneTagGroupName FROM %@ WHERE %@",DBSceneTagList,[condationArray componentsJoinedByString:@" OR "]];
        
        FMResultSet *rs = [[self getDB] executeQuery:sql];
        while ([rs next]) {
            
            NSMutableDictionary *groupInfoDic = [NSMutableDictionary dictionaryWithCapacity:0];
            [groupInfoDic setObject:[rs stringForColumn:@"sceneTagGroupId"] forKey:@"sceneGroupId"];
            [groupInfoDic setObject:[rs stringForColumn:@"sceneTagGroupName"] forKey:@"sceneGroupName"];
            [groupArray addObject:groupInfoDic];
        }
    }
    
    
    
    return [groupArray copy];
}


@end
