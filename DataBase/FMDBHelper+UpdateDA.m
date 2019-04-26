//
//  FMDBHelper+UpdateDA.m
//  EDA
//
//  Created by shichuang on 2016/11/11.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper+UpdateDA.h"

@implementation FMDBHelper (UpdateDA)

#pragma mark - 创建更新文件数据库表
- (void)createUpdateFileTableOnDB
{
    
    // 更新文件数据库表
    if([[self getDB] tableExists:kDBTableUpdateFileList] == NO){
        NSString *departmentsql = @"CREATE TABLE IF NOT EXISTS %@(\
        _id INTEGER PRIMARY KEY AUTOINCREMENT,\
        fileName             text,\
        fileDisplayTime      text,\
        fileId               text,\
        fileSize             text,\
        fileURL              text,\
        downloadTime         text,\
        fileImageUrlStr      text,\
        downloadCompleteTime text,\
        fileTagMark          text,\
        fileIntroduction     text,\
        companyId            text,\
        fileFolderId         text,\
        fileAttention        text,\
        folderTreePath       text,\
        fileStatus           text,\
        lastModifiTime       text,\
        lastPublishVersion   text,\
        lastPublishDate      text,\
        fileRemark           text,\
        fileCustomTag        text,\
        fileVersionId        text,\
        updateNotes          text,\
        downloadState        INTEGER,\
        hasUnZip             INTEGER,\
        isUpdate             INTEGER,\
        UNIQUE(fileId))";
        
        departmentsql = [NSString stringWithFormat:departmentsql, kDBTableUpdateFileList];
        BOOL state = [[self getDB] executeUpdate:departmentsql];
        if (!state) {
            DLog(@"error when create dbTable kDBTableUpdateFileList");
        } else {
            DLog(@"success to create dbTable kDBTableUpdateFileList");
        }
    }
}

// 插入更新文件数据   当开始点击下载时就会插入数据库
- (void)insertUpdateCloudData:(CloudDataModel *)model
{
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(fileName,fileDisplayTime,fileId,fileSize,fileURL,downloadTime,fileImageUrlStr,downloadCompleteTime,fileTagMark,fileIntroduction,companyId,fileFolderId,folderTreePath,fileStatus,lastModifiTime,lastPublishVersion,lastPublishDate,fileAttention,fileRemark,fileCustomTag,fileVersionId,updateNotes,downloadState,hasUnZip,isUpdate)VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%ld','%d','%d')",kDBTableUpdateFileList,[model.fileName safeForFMDBString],[model.fileDisplayTime safeForFMDBString],[model.fileId safeForFMDBString],[model.fileSize safeForFMDBString],[model.fileURL safeForFMDBString],[model.downloadTime safeForFMDBString],[model.fileImageUrlStr safeForFMDBString],[model.downloadCompleteTime safeForFMDBString],[model.fileTagMark safeForFMDBString],[model.fileIntroduction safeForFMDBString],[model.companyId safeForFMDBString],[model.fileFolderId safeForFMDBString],[model.folderTreePath safeForFMDBString],[model.fileStatus safeForFMDBString],[model.lastModifiTime safeForFMDBString],[model.lastPublishVersion safeForFMDBString],[model.lastPublishDate safeForFMDBString],[model.fileAttention safeForFMDBString],[model.fileRemark safeForFMDBString],[model.fileCustomTag safeForFMDBString],[model.fileVersionId safeForFMDBString],[model.updateNotes safeForFMDBString],(long)model.downloadState,model.hasUnZip,model.isUpdate];
    BOOL resSqls = [[self getDB] executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBTableUpdateFileList");
    } else {
        DLog(@"success to insert dbTable kDBTableUpdateFileList");
    }
}
// 根据事务传入db,插入更新文件数据   当开始点击下载时就会插入数据库
- (void)insertUpdateCloudData:(CloudDataModel *)model dataBase:(FMDatabase *)db
{
    if (!db) {
        [self insertUpdateCloudData:model];
        return;
    }
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(fileName,fileDisplayTime,fileId,fileSize,fileURL,downloadTime,fileImageUrlStr,downloadCompleteTime,fileTagMark,fileIntroduction,companyId,fileFolderId,folderTreePath,fileStatus,lastModifiTime,lastPublishVersion,lastPublishDate,fileAttention,fileRemark,fileCustomTag,fileVersionId,updateNotes,downloadState,hasUnZip,isUpdate)VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%ld','%d','%d')",kDBTableUpdateFileList,[model.fileName safeForFMDBString],[model.fileDisplayTime safeForFMDBString],[model.fileId safeForFMDBString],[model.fileSize safeForFMDBString],[model.fileURL safeForFMDBString],[model.downloadTime safeForFMDBString],[model.fileImageUrlStr safeForFMDBString],[model.downloadCompleteTime safeForFMDBString],[model.fileTagMark safeForFMDBString],[model.fileIntroduction safeForFMDBString],[model.companyId safeForFMDBString],[model.fileFolderId safeForFMDBString],[model.folderTreePath safeForFMDBString],[model.fileStatus safeForFMDBString],[model.lastModifiTime safeForFMDBString],[model.lastPublishVersion safeForFMDBString],[model.lastPublishDate safeForFMDBString],[model.fileAttention safeForFMDBString],[model.fileRemark safeForFMDBString],[model.fileCustomTag safeForFMDBString],[model.fileVersionId safeForFMDBString],[model.updateNotes safeForFMDBString],(long)model.downloadState,model.hasUnZip,model.isUpdate];
    BOOL resSqls = [db executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBTableUpdateFileList");
    } else {
        DLog(@"success to insert dbTable kDBTableUpdateFileList");
    }
}


//更新文件状态
- (void)updateCloudDataStateWithUpdateCloudData:(CloudDataModel *) model
{
    //需要添加下载完成时间
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET downloadState = '%ld', downloadCompleteTime = '%@' WHERE fileId = '%@'",kDBTableUpdateFileList,(long)model.downloadState,[model.downloadCompleteTime safeForFMDBString],[model.fileId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBTableUpdateFileList downloadState %ld",(long)model.downloadState);
    } else {
        DLog(@"success to update dbTable kDBTableUpdateFileList downloadState %ld",(long)model.downloadState);
    }
}

//删除某条更新数据
- (void)deleteUpdateCloudData:(CloudDataModel *) model
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE fileId = '%@'",kDBTableUpdateFileList,[model.fileId safeForFMDBString]];
    
    BOOL resSqls = [[self getDB] executeUpdate:sql];
    if (!resSqls) {
        DLog(@"error when delete downLoadModel from dbTable kDBTableUpdateFileList");
    } else {
        DLog(@"success to delete downLoadModel from dbTable kDBTableUpdateFileList");
    }
}

//查询更新数据库中是否存在某个文件
- (BOOL)hasUpdateDownloadFile:(NSString *) fileId
{
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileId = '%@' AND fileStatus <> '4'",kDBTableUpdateFileList,[fileId safeForFMDBString]];
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

//根据已下载数据库文件id获取更新数据库中的更新信息model用来更新
- (CloudDataModel *)getUpdateModelWithFileId:(NSString *) fileId
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileId = '%@'",kDBTableUpdateFileList,fileId];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    return [groupArray lastObject];
}

//删除更新资料库的所有数据
- (void)deleteAllUpdateCloudData
{
    NSString *strSql = [NSString stringWithFormat:@"delete from %@",kDBTableUpdateFileList];
    
    BOOL resSqls = [[self getDB] executeUpdate:strSql];
    if (!resSqls) {
        DLog(@"error when delete downLoadModel from dbTable kDBTableUpdateFileList");
    } else {
        DLog(@"success to delete downLoadModel from dbTable kDBTableUpdateFileList");
    }
}

//查询未下载完成为正在下载状态的所有文件
- (NSMutableArray *)queryUpdateingDAFile
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE downloadState in (0)",kDBTableUpdateFileList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    return groupArray;
}

//查询所有在下载队列中的所有文件
- (NSArray *)queryUpdatedQueueListModel
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE downloadState in (0,1,2)",kDBTableUpdateFileList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    return groupArray.copy;
}

//查询正在等待下载的所有文件
- (NSMutableArray *)queryWaitUpdateDAFile
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE downloadState in (1,2)",kDBTableUpdateFileList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    return groupArray;
}

//查询未开始下载的更新文件
- (NSMutableArray *)queryUpdateNoDownloadDAFile
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE downloadState = 6 AND fileStatus <> '4'",kDBTableUpdateFileList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    return groupArray;

}

//判断某个文件是否未开始下载
- (BOOL)hasUpdateDownloadingFile:(NSString *) fileId
{
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileId = '%@' AND downloadState = 6 AND fileStatus <> '4'",kDBTableUpdateFileList,[fileId safeForFMDBString]];
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


@end
