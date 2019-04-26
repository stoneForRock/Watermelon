//
//  FMDBHelper+FolderTree.m
//  EDA
//
//  Created by shichuang on 16/10/17.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper+FolderTree.h"

@implementation FMDBHelper (FolderTree)

#pragma mark - 创建文件夹目录数据库表
- (void)createFileFolderTreeTableOnDB
{
    if([[self getDB] tableExists:DBFileFolderList] == NO){
        NSString *departmentsql = @"CREATE TABLE IF NOT EXISTS %@(\
        _id INTEGER PRIMARY KEY AUTOINCREMENT,\
        fileFolderDiskId             text,\
        fileFolderId                 text,\
        fileFolderName               text,\
        fileFolderParentId           text,\
        fileFolderLogoUrl            text,\
        fileFolderDesc               text,\
        fileFolderTreePath           text,\
        fileFolderType               text,\
        goodsGroupId                 text,\
        hasSubFileFolder             int,\
        hasDAFile                    int,\
        UNIQUE(fileFolderId))";
        
        departmentsql = [NSString stringWithFormat:departmentsql, DBFileFolderList];
        BOOL state = [[self getDB] executeUpdate:departmentsql];
        if (!state) {
            DLog(@"error when create dbTable DBFileFolderList");
        } else {
            DLog(@"success to create dbTable DBFileFolderList");
        }
    }

}

// 插入文件夹目录model
- (void)insertFileFolderTree:(FolderTreeModel *)model
{
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(fileFolderDiskId,fileFolderId,fileFolderName,fileFolderParentId,fileFolderLogoUrl,fileFolderDesc,fileFolderTreePath,fileFolderType,goodsGroupId,hasSubFileFolder,hasDAFile)VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%d','%d')",DBFileFolderList,[model.fileFolderDiskId safeForFMDBString],[model.fileFolderId safeForFMDBString],[model.fileFolderName safeForFMDBString],[model.fileFolderParentId safeForFMDBString],[model.fileFolderLogoUrl safeForFMDBString],[model.fileFolderDesc safeForFMDBString],[model.fileFolderTreePath safeForFMDBString],[model.fileFolderType safeForFMDBString],[model.goodsGroupId safeForFMDBString],model.hasSubFileFolder,model.hasDAFile];
    BOOL resSqls = [[self getDB] executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBFileFolderList");
    } else {
        DLog(@"success to insert dbTable kDBFileFolderList");
    }
}
// 根据事务传入db,插入文件夹目录model
- (void)insertFileFolderTree:(FolderTreeModel *)model dataBase:(FMDatabase *)db
{
    if (!db) {
        [self insertFileFolderTree:model];
        return;
    }
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(fileFolderDiskId,fileFolderId,fileFolderName,fileFolderParentId,fileFolderLogoUrl,fileFolderDesc,fileFolderTreePath,fileFolderType,goodsGroupId,hasSubFileFolder,hasDAFile)VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%d','%d')",DBFileFolderList,[model.fileFolderDiskId safeForFMDBString],[model.fileFolderId safeForFMDBString],[model.fileFolderName safeForFMDBString],[model.fileFolderParentId safeForFMDBString],[model.fileFolderLogoUrl safeForFMDBString],[model.fileFolderDesc safeForFMDBString],[model.fileFolderTreePath safeForFMDBString],[model.fileFolderType safeForFMDBString],[model.goodsGroupId safeForFMDBString],model.hasSubFileFolder,model.hasDAFile];
    BOOL resSqls = [db executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBFileFolderList");
    } else {
        DLog(@"success to insert dbTable kDBFileFolderList");
    }
}



//更新数据库数据
- (void)updateFileFolderTree:(FolderTreeModel *) model
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET fileFolderDiskId = '%@', fileFolderName = '%@',fileFolderParentId = '%@' , fileFolderLogoUrl = '%@',fileFolderDesc = '%@' , fileFolderTreePath = '%@', fileFolderType = '%@', goodsGroupId = '%@', hasSubFileFolder = '%d',hasDAFile = '%d' where fileFolderId = '%@'",DBFileFolderList,[model.fileFolderDiskId safeForFMDBString],[model.fileFolderName safeForFMDBString],[model.fileFolderParentId safeForFMDBString],[model.fileFolderLogoUrl safeForFMDBString],[model.fileFolderDesc safeForFMDBString],[model.fileFolderTreePath safeForFMDBString],[model.fileFolderType safeForFMDBString],[model.goodsGroupId safeForFMDBString],model.hasSubFileFolder,model.hasDAFile,[model.fileFolderId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBFileFolderList");
    } else {
        DLog(@"success to update dbTable kDBFileFolderList");
    }
}

//根据事务传入的db 更新数据库数据
- (void)updateFileFolderTree:(FolderTreeModel *) model dataBase:(FMDatabase *)db
{
    if (!db) {
        [self updateFileFolderTree:model];
        return;
    }
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET fileFolderDiskId = '%@', fileFolderName = '%@',fileFolderParentId = '%@' , fileFolderLogoUrl = '%@',fileFolderDesc = '%@' , fileFolderTreePath = '%@', fileFolderType = '%@', goodsGroupId = '%@', hasSubFileFolder = '%d',hasDAFile = '%d' where fileFolderId = '%@'",DBFileFolderList,[model.fileFolderDiskId safeForFMDBString],[model.fileFolderName safeForFMDBString],[model.fileFolderParentId safeForFMDBString],[model.fileFolderLogoUrl safeForFMDBString],[model.fileFolderDesc safeForFMDBString],[model.fileFolderTreePath safeForFMDBString],[model.fileFolderType safeForFMDBString],[model.goodsGroupId safeForFMDBString],model.hasSubFileFolder,model.hasDAFile,[model.fileFolderId safeForFMDBString]];
    BOOL resSqls = [db executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBFileFolderList");
    } else {
        DLog(@"success to update dbTable kDBFileFolderList");
    }
}


//查询数据库中是否存在某个文件夹目录
- (BOOL)hasFileFolderTree:(NSString *) folderId
{
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileFolderId = '%@'",DBFileFolderList,[folderId safeForFMDBString]];
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

//根据事务传入db，查询数据库中是否存在某个文件夹目录
- (BOOL)hasFileFolderTree:(NSString *) folderId dataBase:(FMDatabase *)db
{
    if (!db) {
        [self hasFileFolderTree:folderId];
    }
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileFolderId = '%@'",DBFileFolderList,[folderId safeForFMDBString]];
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


//查询下一层的子model
- (NSArray *)querySubListModelWithParentModel:(FolderTreeModel *) model hasDAFile:(BOOL) hasDAFile
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql;
    
    if (hasDAFile)
    {
        sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileFolderParentId = '%@' AND hasDAFile = '%d'",DBFileFolderList,[model.fileFolderId safeForFMDBString],hasDAFile];
    }else
    {
        sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileFolderParentId = '%@'",DBFileFolderList,[model.fileFolderId safeForFMDBString]];
    }
    
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next])
    {
        FolderTreeModel *model = [[FolderTreeModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

//获取根目录model
- (FolderTreeModel *)getRootModel
{
    NSMutableArray *rootArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileFolderParentId = '%@'",DBFileFolderList,@"0"];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        FolderTreeModel *model = [[FolderTreeModel alloc] initWithFMDBSet:rs];
        [rootArray addObject:model];
    }
    
    FolderTreeModel *rootTreeModel = [rootArray lastObject];
    
    return rootTreeModel;
}

//获取根目录下文件
- (NSArray *)queryRootListModelHasDAFile:(BOOL) hasDAFile
{
    NSMutableArray *groupArray = @[].mutableCopy;
    
    NSMutableArray *rootArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileFolderParentId = '%@'",DBFileFolderList,@"0"];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        FolderTreeModel *model = [[FolderTreeModel alloc] initWithFMDBSet:rs];
        [rootArray addObject:model];
    }
    
    FolderTreeModel *rootTreeModel = [rootArray lastObject];
    NSString *sqlString;
    
    if (hasDAFile)
    {
        sqlString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileFolderParentId = '%@' AND hasDAFile = '%d'",DBFileFolderList,[rootTreeModel.fileFolderId safeForFMDBString],hasDAFile];
    }else
    {
        sqlString = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileFolderParentId = '%@'",DBFileFolderList,[rootTreeModel.fileFolderId safeForFMDBString]];
    }
    FMResultSet *resultSet = [[self getDB] executeQuery:sqlString];
    
    while ([resultSet next]) {
        
        FolderTreeModel *model = [[FolderTreeModel alloc] initWithFMDBSet:resultSet];
        [groupArray addObject:model];
    }
    
    return [groupArray copy];
}

//根据文件夹路径更新，是否含有DA文件字段,用来在演示路径查找DA中是否显示
- (void)updateFileFolderTreeHasDAFileStatus:(BOOL) hasDAFile folderId:(NSString *) folderId
{
    NSString *findFolderTreeSql = [NSString stringWithFormat:@"SELECT * FROM %@ where fileFolderId = '%@'",DBFileFolderList,[folderId safeForFMDBString]];
    FMResultSet *rs = [[self getDB] executeQuery:findFolderTreeSql];
    while ([rs next])
    {
        FolderTreeModel *model = [[FolderTreeModel alloc] initWithFMDBSet:rs];
        NSArray *fileFolderIds = [model.fileFolderTreePath componentsSeparatedByString:@"/"];
        for (NSString *fileFolderId in fileFolderIds)
        {
            if (fileFolderId.length > 0)
            {
                NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET hasDAFile = '%d' WHERE fileFolderId = '%@'",DBFileFolderList,hasDAFile,[fileFolderId safeForFMDBString]];
                BOOL resSqls = [[self getDB] executeUpdate:strSQL];
                if (!resSqls)
                {
                    DLog(@"error when update db DBFileFolderList");
                } else {
                    DLog(@"success to update db DBFileFolderList");
                }
            }
        }
    }
 
}

//删除所有DA文件的时候，需要把所有的有DA字段改为NO
- (void)changeAllTreeFolderHasDAFileStatusToNO
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET hasDAFile = '%d'",DBFileFolderList,NO];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls)
    {
        DLog(@"error when update db DBFileFolderList");
    } else {
        DLog(@"success to update db DBFileFolderList");
    }
}

//根据文件夹目录Id获取目录对象
- (FolderTreeModel *)getFolderTreeModelWithFolderId:(NSString *) folderId
{
    NSMutableArray *groupArray = @[].mutableCopy;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where fileFolderId = '%@'",DBFileFolderList,[folderId safeForFMDBString]];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        FolderTreeModel *model = [[FolderTreeModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    return [groupArray lastObject];
}

//查询所有的组织树
- (NSArray *)queryAllFolderTree
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",DBFileFolderList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        FolderTreeModel *model = [[FolderTreeModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

//通过事务传入db 查询所有的组织树
- (NSArray *)queryAllFolderTreeWithDataBase:(FMDatabase *)db {
    if (!db) {
        [self queryAllFolderTree];
    }
    
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",DBFileFolderList];
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        
        FolderTreeModel *model = [[FolderTreeModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
    
}

//获取所有父节点id
- (NSArray *)quertAllFolderParentId
{
    NSMutableArray *groupArray = @[].mutableCopy;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT distinct fileFolderParentId FROM %@",DBFileFolderList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next])
    {
        [groupArray addObject:[rs stringForColumn:@"fileFolderParentId"]];
    }
    
    return [groupArray copy];
}

//通过事务传入db  获取所有父节点id
- (NSArray *)quertAllFolderParentIdWithDataBase:(FMDatabase *)db
{
    if (!db) {
        [self quertAllFolderParentId];
    }
    NSMutableArray *groupArray = @[].mutableCopy;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT distinct fileFolderParentId FROM %@",DBFileFolderList];
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next])
    {
        [groupArray addObject:[rs stringForColumn:@"fileFolderParentId"]];
    }
    
    return [groupArray copy];
}


@end
