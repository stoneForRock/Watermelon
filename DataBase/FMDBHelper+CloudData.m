//
//  FMDBHelper+CloudData.m
//  EDA
//
//  Created by shichuang on 16/10/17.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper+CloudData.h"
#import "FMDBHelper+UpdateDA.h"
#import "FMDBHelper+SceneTag.h"

@implementation FMDBHelper (CloudData)

#pragma mark - 创建下载文件数据库表
- (void)createDownLoadFileTableOnDB {
    
    // 下载文件数据库表
    if([[self getDB] tableExists:kDBTableDownLoadFileList] == NO){
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
        lastDisplayTime      text,\
        pageLogoUrls         text,\
        updateNotes          text,\
        downloadState        INTEGER,\
        hasUnZip             INTEGER,\
        isUpdate             INTEGER,\
        type                 text,\
        UNIQUE(fileId))";
        
        departmentsql = [NSString stringWithFormat:departmentsql, kDBTableDownLoadFileList];
        BOOL state = [[self getDB] executeUpdate:departmentsql];
        if (!state) {
            DLog(@"error when create dbTable kDBTableDownLoadFileList");
        } else {
            DLog(@"success to create dbTable kDBTableDownLoadFileList");
        }
    }
}

// 插入下载文件数据   当开始点击下载时就会插入数据库
- (void)insertCloudData:(CloudDataModel *)model
{
    //插入数据时，防止备注、标签数据的流失
    if (!StringNotEmpty(model.fileCustomTag)&& !StringNotEmpty(model.fileRemark)) {
        CloudDataModel *cloudDataModel = [[FMDBHelper defaultDBHelper]queryCloudDataModelWithFileId:model.fileId];
        if (StringNotEmpty(cloudDataModel.fileCustomTag) || StringNotEmpty(cloudDataModel.fileRemark)) {
            model.fileRemark = cloudDataModel.fileRemark;
            model.fileCustomTag = cloudDataModel.fileCustomTag;
        }
    }
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(fileName,fileDisplayTime,fileId,fileSize,fileURL,downloadTime,fileImageUrlStr,downloadCompleteTime,fileTagMark,fileIntroduction,companyId,fileFolderId,folderTreePath,fileStatus,lastModifiTime,lastPublishVersion,lastPublishDate,fileAttention,fileRemark,fileCustomTag,fileVersionId,lastDisplayTime,pageLogoUrls,updateNotes,downloadState,hasUnZip,isUpdate,type)VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%ld','%d','%d','%@')",kDBTableDownLoadFileList,[model.fileName safeForFMDBString],[model.fileDisplayTime safeForFMDBString],[model.fileId safeForFMDBString],[model.fileSize safeForFMDBString],[model.fileURL safeForFMDBString],[model.downloadTime safeForFMDBString],[model.fileImageUrlStr safeForFMDBString],[model.downloadCompleteTime safeForFMDBString],[model.fileTagMark safeForFMDBString],[model.fileIntroduction safeForFMDBString],[model.companyId safeForFMDBString],[model.fileFolderId safeForFMDBString],[model.folderTreePath safeForFMDBString],model.fileStatus,[model.lastModifiTime safeForFMDBString],[model.lastPublishVersion safeForFMDBString],[model.lastPublishDate safeForFMDBString],[model.fileAttention safeForFMDBString],[model.fileRemark safeForFMDBString],[model.fileCustomTag safeForFMDBString],[model.fileVersionId safeForFMDBString],[model.lastDisplayTime safeForFMDBString],[model.pageLogoUrls safeForFMDBString],[model.updateNotes safeForFMDBString],(long)model.downloadState,model.hasUnZip,model.isUpdate,[model.type safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBTableDownLoadFileList");
    } else {
        DLog(@"success to insert dbTable kDBTableDownLoadFileList");
    }
}
// 根据事务传入db,插入下载文件数据   当开始点击下载时就会插入数据库
- (void)insertCloudData:(CloudDataModel *)model dataBase:(FMDatabase *)db
{
    if (!db) {
        [self insertCloudData:model];
        return;
    }
    //插入数据时，防止备注、标签数据的流失
    if (!StringNotEmpty(model.fileCustomTag)&& !StringNotEmpty(model.fileRemark)) {
        CloudDataModel *cloudDataModel = [[FMDBHelper defaultDBHelper]queryCloudDataModelWithFileId:model.fileId dataBase:db];
        if (StringNotEmpty(cloudDataModel.fileCustomTag) || StringNotEmpty(cloudDataModel.fileRemark)) {
            model.fileRemark = cloudDataModel.fileRemark;
            model.fileCustomTag = cloudDataModel.fileCustomTag;
        }
    }
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(fileName,fileDisplayTime,fileId,fileSize,fileURL,downloadTime,fileImageUrlStr,downloadCompleteTime,fileTagMark,fileIntroduction,companyId,fileFolderId,folderTreePath,fileStatus,lastModifiTime,lastPublishVersion,lastPublishDate,fileAttention,fileRemark,fileCustomTag,fileVersionId,lastDisplayTime,pageLogoUrls,updateNotes,downloadState,hasUnZip,isUpdate,type)VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%ld','%d','%d','%@')",kDBTableDownLoadFileList,[model.fileName safeForFMDBString],[model.fileDisplayTime safeForFMDBString],[model.fileId safeForFMDBString],[model.fileSize safeForFMDBString],[model.fileURL safeForFMDBString],[model.downloadTime safeForFMDBString],[model.fileImageUrlStr safeForFMDBString],[model.downloadCompleteTime safeForFMDBString],[model.fileTagMark safeForFMDBString],[model.fileIntroduction safeForFMDBString],[model.companyId safeForFMDBString],[model.fileFolderId safeForFMDBString],[model.folderTreePath safeForFMDBString],model.fileStatus,[model.lastModifiTime safeForFMDBString],[model.lastPublishVersion safeForFMDBString],[model.lastPublishDate safeForFMDBString],[model.fileAttention safeForFMDBString],[model.fileRemark safeForFMDBString],[model.fileCustomTag safeForFMDBString],[model.fileVersionId safeForFMDBString],[model.lastDisplayTime safeForFMDBString],[model.pageLogoUrls safeForFMDBString],[model.updateNotes safeForFMDBString],(long)model.downloadState,model.hasUnZip,model.isUpdate,[model.type safeForFMDBString]];
    BOOL resSqls = [db executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBTableDownLoadFileList");
    } else {
        DLog(@"success to insert dbTable kDBTableDownLoadFileList");
    }
}

//根据服务器返回数据对数据库进行更新
- (void)updateCloudDataInfoWithCloudData:(CloudDataModel *) model
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET fileName = '%@', fileDisplayTime = '%@', fileSize = '%@' , fileURL = '%@',downloadTime = '%@' , fileImageUrlStr = '%@', downloadCompleteTime = '%@', fileTagMark = '%@',fileIntroduction = '%@' ,companyId = '%@',fileFolderId = '%@',folderTreePath = '%@',fileStatus = '%@',lastModifiTime = '%@',lastPublishVersion = '%@',lastPublishDate = '%@',fileAttention = '%@', fileRemark = '%@',fileCustomTag = '%@',fileVersionId = '%@',lastDisplayTime = '%@',pageLogoUrls = '%@',updateNotes = '%@',downloadState = '%lld',hasUnZip = '%d',isUpdate = '%d',type = '%@'  where fileId = '%@'",kDBTableDownLoadFileList,[model.fileName safeForFMDBString],[model.fileDisplayTime safeForFMDBString],[model.fileSize safeForFMDBString],[model.fileURL safeForFMDBString],[model.downloadTime safeForFMDBString],[model.fileImageUrlStr safeForFMDBString],[model.downloadCompleteTime safeForFMDBString],[model.fileTagMark safeForFMDBString],[model.fileIntroduction safeForFMDBString],[model.companyId safeForFMDBString],[model.fileFolderId safeForFMDBString],[model.folderTreePath safeForFMDBString],[model.fileStatus safeForFMDBString],[model.lastModifiTime safeForFMDBString],[model.lastPublishVersion safeForFMDBString],[model.lastPublishDate safeForFMDBString],[model.fileAttention safeForFMDBString],[model.fileRemark safeForFMDBString],[model.fileCustomTag safeForFMDBString],[model.fileVersionId safeForFMDBString],[model.lastDisplayTime safeForFMDBString],[model.pageLogoUrls safeForFMDBString],[model.updateNotes safeForFMDBString],(long long)model.downloadState,model.hasUnZip,model.isUpdate,[model.type safeForFMDBString],[model.fileId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBTableDownLoadFileList");
    } else {
        DLog(@"success to update dbTable kDBTableDownLoadFileList");
    }
}


//更新记录最后演示时间
- (void)updateFileDisplayLastTime:(CloudDataModel *) model
{
    //需要添加下载完成时间
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET lastDisplayTime =  '%@' WHERE fileId = '%@'",kDBTableDownLoadFileList,[model.lastDisplayTime safeForFMDBString],[model.fileId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBTableDownLoadFileList lastDisplayTime %@",model.lastDisplayTime);
    } else {
        DLog(@"success to update dbTable kDBTableDownLoadFileList lastDisplayTime  %@",model.lastDisplayTime);
    }
}

//更新文件状态
- (void)updateCloudDataStateWithCloudData:(CloudDataModel *) model
{
    //需要添加下载完成时间
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET downloadState = '%ld', downloadCompleteTime = '%@' WHERE fileId = '%@'",kDBTableDownLoadFileList,(long)model.downloadState,[model.downloadCompleteTime safeForFMDBString],[model.fileId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBTableDownLoadFileList downloadState %ld",(long)model.downloadState);
    } else {
        DLog(@"success to update dbTable kDBTableDownLoadFileList downloadState %ld",(long)model.downloadState);
    }

}

//更新文件下载完成时间，用来在已下载中进行排序
- (void)updateCloudDataDownloadTimeWithCloudData:(CloudDataModel *) model
{
    //需要添加下载完成时间
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET downloadCompleteTime = '%@' WHERE fileId = '%@'",kDBTableDownLoadFileList,[model.downloadCompleteTime safeForFMDBString],[model.fileId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBTableDownLoadFileList downloadCompleteTime %ld",(long)model.downloadState);
    } else {
        DLog(@"success to update dbTable kDBTableDownLoadFileList downloadCompleteTime %ld",(long)model.downloadState);
    }
    
}

//更新文件是否已解压状态
- (void)updateCloudDataZipStatus:(CloudDataModel *) model
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET hasUnZip = '%d' where  fileId = '%@'",kDBTableDownLoadFileList,model.hasUnZip,[model.fileId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update db kDBTableDownLoadFileList");
    } else {
        DLog(@"success to update db kDBTableDownLoadFileList");
    }
}

//清除缓存时，把所有解压状态修改为未解压
- (void)updateAllCloudDataZipStatus
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET hasUnZip = '%d'",kDBTableDownLoadFileList,0];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update db kDBTableDownLoadFileList");
    } else {
        DLog(@"success to update db kDBTableDownLoadFileList");
    }
}

//删除某条数据
- (void)deleteCloudData:(CloudDataModel *) model
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE fileId = '%@'",kDBTableDownLoadFileList,[model.fileId safeForFMDBString]];
    
    BOOL resSqls = [[self getDB] executeUpdate:sql];
    if (!resSqls) {
        DLog(@"error when delete downLoadModel from dbTable kDBTableDownLoadFileList");
    } else {
        DLog(@"success to delete downLoadModel from dbTable kDBTableDownLoadFileList");
    }
    
}

//根据fileID查询数据库中的model
- (CloudDataModel *)queryCloudDataModelWithFileId:(NSString *) fileId
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileId = '%@'",kDBTableDownLoadFileList,fileId];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    return [groupArray lastObject];
}
//根据事务传入db,根据fileID查询数据库中的model
- (CloudDataModel *)queryCloudDataModelWithFileId:(NSString *) fileId dataBase:(FMDatabase *)db
{
    if (!db) {
        [self queryCloudDataModelWithFileId:fileId];
    }
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileId = '%@'",kDBTableDownLoadFileList,fileId];
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    return [groupArray lastObject];
}


//查询所有已下载完成的DA文件
- (NSMutableArray *)queryAllDownloadedDA
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE downloadState = '%d'",kDBTableDownLoadFileList,3];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    return groupArray;
}

//根据是否显示已作废来过滤所有已下载完成的DA
- (NSMutableArray *)queryAllDownloadedDAHidenInvalid:(BOOL) hidenInvalid
{
    NSMutableArray *groupArray = @[].mutableCopy;
    
    NSString *condationString = @"";
    if (hidenInvalid)
    {
        condationString = [NSString stringWithFormat:@"AND fileStatus <> '4'"];
        
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE downloadState = '%d' %@ order by downloadCompleteTime desc ,fileTagMark,fileDisplayTime",kDBTableDownLoadFileList,3,condationString];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    return groupArray;
}

//查询某个文件夹路径下的DA文件
- (NSMutableArray *)queryDownloadDAWithFileFolderId:(NSString *) fileFolderId
{
    BOOL hidenInvalid = [[[NSUserDefaults standardUserDefaults] objectForKey:kHidenInvalidFileOnOff] boolValue];
    
    NSString *hidenSql = [NSString stringWithFormat:@"AND fileStatus <> '4'"];
    
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql;
    if (hidenInvalid)
    {
        sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileFolderId = '%@' AND downloadState = 3 %@ order by lastDisplayTime DESC",kDBTableDownLoadFileList,[fileFolderId safeForFMDBString],hidenSql];
    }else
    {
        sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileFolderId = '%@' AND downloadState = 3 order by lastDisplayTime DESC",kDBTableDownLoadFileList,[fileFolderId safeForFMDBString]];
    }
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    return groupArray;

}

//查询数据库中是否存在某个文件
- (BOOL)hasDownloadFile:(NSString *) fileId
{
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileId = '%@'",kDBTableDownLoadFileList,[fileId safeForFMDBString]];
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
//根据传入事务，查询数据库中是否存在某个文件
- (BOOL)hasDownloadFile:(NSString *) fileId dataBase:(FMDatabase *)db
{
    if (!db) {
        [self hasDownloadFile:fileId dataBase:db];
    }
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE fileId = '%@'",kDBTableDownLoadFileList,[fileId safeForFMDBString]];
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

//查询未下载完成为正在下载状态的所有文件
- (NSMutableArray *)queryDownloadingDAFile
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE downloadState in (0)",kDBTableDownLoadFileList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    return groupArray;
}

//查询正在等待下载的所有文件
- (NSMutableArray *)queryWaitDownloadDAFile
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE downloadState in (1,2)",kDBTableDownLoadFileList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    return groupArray;
}

//查询所有在下载队列中的所有文件
- (NSMutableArray *)queryDownloadQueueListModel
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE downloadState in (0,1,2)",kDBTableDownLoadFileList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    return groupArray;
}

//查询正在下载中界面过滤数据，包括目录，场景
- (NSMutableArray *)queryFilterDownloadingDAFileWithFolderId:(NSString *) folderId
                                                 sceneTag:(NSString *) sceneTag
{
    NSMutableArray *groupArray = @[].mutableCopy;
    
    NSMutableArray *sqlConditions = [NSMutableArray arrayWithCapacity:0];
    if (folderId)
    {
        [sqlConditions addObject:[NSString stringWithFormat:@"fileFolderId = '%@'",[folderId safeForFMDBString]]];
    }
    
    if (sceneTag)
    {
        [sqlConditions addObject:[NSString stringWithFormat:@"fileTagMark = '%@'",[sceneTag safeForFMDBString]]];
    }
    
    NSString *sqlConditionsString = [sqlConditions componentsJoinedByString:@" AND "];
    if (sqlConditionsString.length > 0) {
        sqlConditionsString = [sqlConditionsString stringByAppendingString:@" AND "];
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@  downloadState in (0,1,2)",kDBTableDownLoadFileList,sqlConditionsString];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    
    
    
    return groupArray;
}

//查询已下载界面过滤数据，包括目录，场景，DA标签 和关键字搜索
- (NSMutableArray *)queryFilterDownloadDAFileWithFolderId:(NSString *) folderId
                                                 sceneTag:(NSString *) sceneTag
                                             coustomDATag:(NSString *) coustomDATag
                                                searchKey:(NSString *) searchKey
{
    folderId = [folderId safeForFMDBString];
    sceneTag = [sceneTag safeForFMDBString];
    coustomDATag = [coustomDATag safeForFMDBString];
    searchKey = [searchKey safeForFMDBString];
    
    
    BOOL hidenInvalid = [[[NSUserDefaults standardUserDefaults] objectForKey:kHidenInvalidFileOnOff] boolValue];
    
    NSMutableArray *groupArray = @[].mutableCopy;
    
    NSMutableArray *sqlConditions = [NSMutableArray arrayWithCapacity:0];
    if (folderId)
    {
        [sqlConditions addObject:[NSString stringWithFormat:@"fileFolderId = '%@'",folderId]];
    }
    
    if (sceneTag)
    {
        NSMutableArray *sceneTagSqls = [NSMutableArray arrayWithCapacity:0];
        [sceneTagSqls addObject:[NSString stringWithFormat:@"fileTagMark LIKE '%%,%@'",[sceneTag safeForFMDBString]]];
        [sceneTagSqls addObject:[NSString stringWithFormat:@"fileTagMark LIKE '%@,%%'",[sceneTag safeForFMDBString]]];
        [sceneTagSqls addObject:[NSString stringWithFormat:@"fileTagMark LIKE '%%,%@,%%'",[sceneTag safeForFMDBString]]];
        [sceneTagSqls addObject:[NSString stringWithFormat:@"fileTagMark = '%@'",[sceneTag safeForFMDBString]]];
        
        [sqlConditions addObject:[NSString stringWithFormat:@"(%@)",[sceneTagSqls componentsJoinedByString:@" OR "]]];
    }
    
    if (coustomDATag)
    {
        NSArray *coustomTags = [coustomDATag componentsSeparatedByString:@"⊙"];
        if (coustomTags.count > 0)
        {
            NSMutableArray *coustomTagSqls = [NSMutableArray arrayWithCapacity:0];
            for (NSString *coustomTagString in coustomTags)
            {
                [coustomTagSqls addObject:[NSString stringWithFormat:@"fileCustomTag LIKE '%%⊙%@'",[coustomTagString safeForFMDBString]]];
                [coustomTagSqls addObject:[NSString stringWithFormat:@"fileCustomTag LIKE '%@⊙%%'",[coustomTagString safeForFMDBString]]];
                [coustomTagSqls addObject:[NSString stringWithFormat:@"fileCustomTag LIKE '%%⊙%@⊙%%'",[coustomTagString safeForFMDBString]]];
                [coustomTagSqls addObject:[NSString stringWithFormat:@"fileCustomTag = '%@'",[coustomTagString safeForFMDBString]]];
            }
            [sqlConditions addObject:[NSString stringWithFormat:@"(%@)",[coustomTagSqls componentsJoinedByString:@" OR "]]];
        }
    }
    
    if (searchKey)
    {
        [sqlConditions addObject:[NSString stringWithFormat:@"(fileName LIKE '%%%@%%' OR fileIntroduction LIKE '%%%@%%')",searchKey,searchKey]];
    }
    
    NSString *sqlConditionsString = [sqlConditions componentsJoinedByString:@" AND "];
    if (sqlConditionsString.length > 0) {
        sqlConditionsString = [sqlConditionsString stringByAppendingString:@" AND "];
    }
    
    
    NSString *condationString = @"";
    if (hidenInvalid)
    {
        condationString = [NSString stringWithFormat:@"AND fileStatus <> '4'"];
        
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@  downloadState = 3 %@  order by downloadCompleteTime desc ,fileTagMark,fileDisplayTime",kDBTableDownLoadFileList,sqlConditionsString,condationString];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }

    
    
    return groupArray;
}

//删除资料库的所有数据
- (void)deleteAllCloudData
{
    NSString *strSql = [NSString stringWithFormat:@"delete from %@",kDBTableDownLoadFileList];
    
    BOOL resSqls = [[self getDB] executeUpdate:strSql];
    if (!resSqls) {
        DLog(@"error when delete downLoadModel from dbTable kDBTableDownLoadFileList");
    } else {
        DLog(@"success to delete downLoadModel from dbTable kDBTableDownLoadFileList");
    }
}

//查询某个路径下DA文件所有的场景标签 名称
- (NSMutableArray *)querySceneTagFromDAFileWithFileFolderId:(NSString *) fileFolderId
{
    
    fileFolderId = [fileFolderId safeForFMDBString];
    NSMutableArray *groupArray = @[].mutableCopy;
    
    BOOL hidenInvalid = [[[NSUserDefaults standardUserDefaults] objectForKey:kHidenInvalidFileOnOff] boolValue];
    
    NSString *hidenSql;
    
    if (hidenInvalid)
    {
        hidenSql = [NSString stringWithFormat:@"AND fileStatus <> '4'"];
    }else
    {
        hidenSql = @"";
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT distinct fileTagMark FROM %@ WHERE fileFolderId = '%@' AND downloadState = 3 %@",kDBTableDownLoadFileList,fileFolderId,hidenSql];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next])
    {
        NSString *fileTagMark = [rs stringForColumn:@"fileTagMark"];
        if (fileTagMark.length > 0)
        {
            NSArray *sceneNames = [fileTagMark componentsSeparatedByString:@","];
            for (NSString *sceneName in sceneNames)
            {
                [groupArray addObject:sceneName];
            }
            
        }
    }

    return groupArray;
}

//查询所有已下载DA的场景名称
- (NSMutableArray *)queryAllDownloadedDASceneTagHidenInvalid:(BOOL) hidenInvalid
{
    NSMutableArray *groupArray = @[].mutableCopy;
    
    NSString *hidenSql = @"";
    
    if (hidenInvalid)
    {
        hidenSql = [NSString stringWithFormat:@"AND fileStatus <> '4'"];
    }else
    {
        hidenSql = @"";
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT distinct fileTagMark FROM %@ WHERE downloadState = 3 %@",kDBTableDownLoadFileList,hidenSql];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    
    NSMutableArray *sceneNameArray = [NSMutableArray arrayWithCapacity:0];
    
    while ([rs next])
    {
        NSString *fileTagMark = [rs stringForColumn:@"fileTagMark"];
        if (fileTagMark.length > 0)
        {
            NSArray *sceneNames = [fileTagMark componentsSeparatedByString:@","];
            for (NSString *sceneName in sceneNames)
            {
                if (![sceneNameArray containsObject:sceneName])
                {
                    [sceneNameArray addObject:sceneName];
                }
                
            }
            
        }
    }
    
    for (NSString *sceneName in sceneNameArray)
    {
       SceneTagModel *baseModel = [[FMDBHelper defaultDBHelper] querySceneModelWithSceneName:sceneName];
        if (!baseModel)
        {
            SceneTagModel *tagModel = [[SceneTagModel alloc] init];
            tagModel.sceneTagName = sceneName;
            [groupArray addObject:tagModel];
        }else
        {
            [groupArray addObject:baseModel];
        }
       
    }
    
    return groupArray;
}

//查询某个路径下DA文件所有的时长标签 名称
- (NSMutableArray *)queryTimeTagFromDAFileWithFileFolderId:(NSString *) fileFolderId
{
    fileFolderId = [fileFolderId safeForFMDBString];
    NSMutableArray *groupArray = @[].mutableCopy;
    
    BOOL hidenInvalid = [[[NSUserDefaults standardUserDefaults] objectForKey:kHidenInvalidFileOnOff] boolValue];
    
    NSString *hidenSql;
    
    if (hidenInvalid)
    {
        hidenSql = [NSString stringWithFormat:@"AND fileStatus <> '4'"];
    }else
    {
        hidenSql = @"";
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT distinct fileDisplayTime FROM %@ WHERE fileFolderId = '%@'  AND downloadState = 3 %@",kDBTableDownLoadFileList,fileFolderId,hidenSql];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        NSString *timeName = [rs stringForColumn:@"fileDisplayTime"];
        if (timeName.length > 0) {
            [groupArray addObject:timeName];
        }
        
    }
    
    return groupArray;
}

//查询某个路径下DA文件所有的自定义标签名称
- (NSMutableArray *)queryCustomTagFromDAFileWithFileFolderId:(NSString *) fileFolderId
{
    fileFolderId = [fileFolderId safeForFMDBString];
    NSMutableArray *groupArray = @[].mutableCopy;
    BOOL hidenInvalid = [[[NSUserDefaults standardUserDefaults] objectForKey:kHidenInvalidFileOnOff] boolValue];
    
    NSString *hidenSql;
    
    if (hidenInvalid)
    {
        hidenSql = [NSString stringWithFormat:@"AND fileStatus <> '4'"];
    }else
    {
        hidenSql = @"";
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT distinct fileCustomTag FROM %@ WHERE fileFolderId = '%@' AND downloadState = 3 %@",kDBTableDownLoadFileList,fileFolderId,hidenSql];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        NSString *customName = [rs stringForColumn:@"fileCustomTag"];
        if (customName.length > 0)
        {
            [groupArray addObject:customName];
        }
        
    }
    
    return groupArray;
}

//查询所有已下载DA文件的所有自定义标签
- (NSArray *)queryAllCustomTagFromDownloadDAFile
{
    NSMutableArray *groupArray = @[].mutableCopy;
    BOOL hidenInvalid = [[[NSUserDefaults standardUserDefaults] objectForKey:kHidenInvalidFileOnOff] boolValue];
    
    NSString *hidenSql;
    
    if (hidenInvalid)
    {
        hidenSql = [NSString stringWithFormat:@"AND fileStatus <> '4'"];
    }else
    {
        hidenSql = @"";
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT distinct fileCustomTag FROM %@ WHERE downloadState = 3 %@",kDBTableDownLoadFileList,hidenSql];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        NSString *customName = [rs stringForColumn:@"fileCustomTag"];
        if (customName.length > 0)
        {
            [groupArray addObjectsFromArray:[customName componentsSeparatedByString:@"⊙"]];
        }
        
    }
    
    return groupArray.copy;
}

//根据演示路径多选条件对已下载界面进行数据过滤
- (NSMutableArray *)queryFilterDownLoadDAFileWithFolderId:(NSString *) folderId
                                                sceneTags:(NSArray *) sceneTags
                                                 timeTags:(NSArray *) timeTags
                                              coustomTags:(NSArray *) coustomTags
                                              updateTimes:(NSArray *) updateTimes
                                                searchKey:(NSString *) searchKey
{
    
    BOOL hidenInvalid = [[[NSUserDefaults standardUserDefaults] objectForKey:kHidenInvalidFileOnOff] boolValue];
    
    NSString *hidenSql;
    
    if (hidenInvalid)
    {
        hidenSql = [NSString stringWithFormat:@"AND fileStatus <> '4'"];
    }else
    {
        hidenSql = @"";
    }
    
    folderId = [folderId safeForFMDBString];
    searchKey = [searchKey safeForFMDBString];
    
    NSMutableArray *groupArray = @[].mutableCopy;
    
    NSMutableArray *sqlConditions = [NSMutableArray arrayWithCapacity:0];
    
    NSString *fileFolderIdSql;
    if (folderId)
    {
        fileFolderIdSql = [NSString stringWithFormat:@"fileFolderId = '%@'",folderId];
    }
    
    if (sceneTags.count > 0)
    {
        NSMutableArray *sceneTagSqls = [NSMutableArray arrayWithCapacity:0];
        for (NSString *sceneTagString in sceneTags)
        {
            [sceneTagSqls addObject:[NSString stringWithFormat:@"fileTagMark LIKE '%%,%@'",[sceneTagString safeForFMDBString]]];
            [sceneTagSqls addObject:[NSString stringWithFormat:@"fileTagMark LIKE '%@,%%'",[sceneTagString safeForFMDBString]]];
            [sceneTagSqls addObject:[NSString stringWithFormat:@"fileTagMark LIKE '%%,%@,%%'",[sceneTagString safeForFMDBString]]];
            [sceneTagSqls addObject:[NSString stringWithFormat:@"fileTagMark = '%@'",[sceneTagString safeForFMDBString]]];
        }
        [sqlConditions addObject:[NSString stringWithFormat:@"(%@)",[sceneTagSqls componentsJoinedByString:@" OR "]]];
    }
    
    if (timeTags.count > 0)
    {
        NSMutableArray *timeTagSqls = [NSMutableArray arrayWithCapacity:0];
        for (NSString *timeTagString in timeTags)
        {
            [timeTagSqls addObject:[NSString stringWithFormat:@"'%@'",[timeTagString safeForFMDBString]]];
        }
        [sqlConditions addObject:[NSString stringWithFormat:@"fileDisplayTime in (%@)",[timeTagSqls componentsJoinedByString:@","]]];
    }
    
    if (coustomTags.count > 0)
    {
        NSMutableArray *coustomTagSqls = [NSMutableArray arrayWithCapacity:0];
        for (NSString *coustomTagString in coustomTags)
        {
            [coustomTagSqls addObject:[NSString stringWithFormat:@"fileCustomTag LIKE '%%⊙%@'",[coustomTagString safeForFMDBString]]];
            [coustomTagSqls addObject:[NSString stringWithFormat:@"fileCustomTag LIKE '%@⊙%%'",[coustomTagString safeForFMDBString]]];
            [coustomTagSqls addObject:[NSString stringWithFormat:@"fileCustomTag LIKE '%%⊙%@⊙%%'",[coustomTagString safeForFMDBString]]];
            [coustomTagSqls addObject:[NSString stringWithFormat:@"fileCustomTag = '%@'",[coustomTagString safeForFMDBString]]];
        }
        [sqlConditions addObject:[NSString stringWithFormat:@"(%@)",[coustomTagSqls componentsJoinedByString:@" OR "]]];
    }
    
    if (updateTimes.count > 0)
    {
        for (NSString *updateTimeString in updateTimes)
        {
            if ([updateTimeString isEqualToString:@"今天"])
            {
                
                [sqlConditions addObject:[NSString stringWithFormat:@"downloadCompleteTime >= '%.f'",[AllQuick getCurrentDayZeroTimeInterval]]];
            }
            
            if ([updateTimeString isEqualToString:@"本周"])
            {
                [sqlConditions addObject:[NSString stringWithFormat:@"downloadCompleteTime > '%.f'",[AllQuick getCurrentWeekZeroTimeInterval]]];
            }
            
        }
        
    }
    
    if (searchKey)
    {
        [sqlConditions addObject:[NSString stringWithFormat:@"fileName LIKE '%%%@%%' OR fileIntroduction LIKE '%%%@%%'",searchKey,searchKey]];
    }
    
    
    NSString *sqlConditionsString = [sqlConditions componentsJoinedByString:@" OR "];
    if (sqlConditionsString.length > 0)
    {
        sqlConditionsString = [NSString stringWithFormat:@"(%@)",sqlConditionsString];
    }

    if (sqlConditionsString.length > 0)
    {
        sqlConditionsString = [sqlConditionsString stringByAppendingString:@" AND "];
        
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@  downloadState = 3 AND %@ %@ order by lastDisplayTime DESC",kDBTableDownLoadFileList,sqlConditionsString,fileFolderIdSql,hidenSql];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CloudDataModel *model = [[CloudDataModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }

    return groupArray;
}

//根据父文件夹路径取下一层文件夹路径
- (NSArray<FolderTreeModel *> *)getNextFileFolderBySuperFileFolderId:(NSString *) superFileFolderId hidenInvalid:(BOOL) hidenInvalid
{
    NSMutableArray *groupArray = @[].mutableCopy;
    
    //查询复合条件的组织树路径
    NSMutableArray *allTreePath = @[].mutableCopy;
    
    NSString *condationString = @"";
    if (hidenInvalid)
    {
        condationString = [NSString stringWithFormat:@"AND fileStatus <> '4'"];
        
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT distinct folderTreePath FROM %@ WHERE downloadState = '%d' %@ ",kDBTableDownLoadFileList,3,condationString];
    
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next])
    {
        
        NSString *folderTreePath = [rs stringForColumn:@"folderTreePath"];
        if (folderTreePath.length > 0)
        {
            //如果包含父id 放到数据源中
            if ([folderTreePath containsString:superFileFolderId])
            {
                [allTreePath addObject:folderTreePath];
            }
        }
    }

    NSMutableArray *subPathStrings = [NSMutableArray arrayWithCapacity:0];
    for (NSString *folderTreePath in allTreePath)
    {
        
        NSArray *siginalTrees = [[folderTreePath substringWithRange:NSMakeRange(1, folderTreePath.length - 1)] componentsSeparatedByString:[NSString stringWithFormat:@"%@",superFileFolderId]];
        
        //如果大于1，说明后面还有子id
        if (siginalTrees.count > 1)
        {
            //直接去除第一个斜杠
            NSString *subTreePath = [siginalTrees[1] substringFromIndex:1];
            
            NSArray *subPaths = [subTreePath componentsSeparatedByString:@"/"];
            
            //取第一个放进去
            if (subPaths.count > 0)
            {
                NSString *subTreePathId = subPaths[0];
                if (![subPathStrings containsObject:subTreePathId])
                {
                    if (subTreePathId.length > 0)
                    {
                        [subPathStrings addObject:subTreePathId];
                    }
                }

            }
            
        }
    }
    
    for (NSString *fileFloderId in subPathStrings)
    {
        [groupArray addObject:[self getFolderTreeModelWithFolderId:fileFloderId]];
    }

    
    return groupArray.copy;
}


//获取所有已下载的fileFolderPath根目录
- (NSArray<FolderTreeModel *> *)getRootFileFolderForAllDownloadedFileWithHidenInvalid:(BOOL) hidenInvalid
{
    NSMutableArray *groupArray = @[].mutableCopy;
    
    //查询所有的组织树路径
    NSMutableArray *allTreePath = @[].mutableCopy;
    
    NSString *condationString = @"";
    if (hidenInvalid)
    {
        condationString = [NSString stringWithFormat:@"AND fileStatus <> '4'"];
        
    }
    
    NSString *sql = [NSString stringWithFormat:@"SELECT distinct folderTreePath FROM %@ WHERE downloadState = '%d' %@ ",kDBTableDownLoadFileList,3,condationString];
    
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next])
    {
        
        NSString *folderTreePath = [rs stringForColumn:@"folderTreePath"];
        if (folderTreePath.length > 0)
        {
            [allTreePath addObject:folderTreePath];
        }
    }
    
    NSMutableArray *rootPathStrings = [NSMutableArray arrayWithCapacity:0];
    for (NSString *folderTreePath in allTreePath)
    {
        NSArray *siginalTrees = [[folderTreePath substringWithRange:NSMakeRange(1, folderTreePath.length - 2)] componentsSeparatedByString:@"/"];
        if (siginalTrees.count > 1)
        {
            if (![rootPathStrings containsObject:siginalTrees[1]])
            {
                [rootPathStrings addObject:siginalTrees[1]];
            }
        }
    }
    
    for (NSString *fileFloderId in rootPathStrings)
    {
        if ([self getFolderTreeModelWithFolderId:fileFloderId])
        {
            [groupArray addObject:[self getFolderTreeModelWithFolderId:fileFloderId]];
        }
       
    }
    
    return groupArray.copy;
}

//判断某个目录下是否有DA文件 如果数据库中有DA的文件对应过去 就是有，没有对应过去 就没有
- (BOOL)hasDAFileInTreePath:(NSString *) treePahtId  hidenInvalid:(BOOL) hidenInvalid
{
    
    NSMutableArray *allFileFolderId = [NSMutableArray arrayWithCapacity:0];
    
    NSString *condationString = @"";
    if (hidenInvalid)
    {
        condationString = [NSString stringWithFormat:@"AND fileStatus <> '4'"];
        
    }

    
    NSString *sql = [NSString stringWithFormat:@"SELECT distinct fileFolderId FROM %@ WHERE downloadState = '%d'  %@ ",kDBTableDownLoadFileList,3,condationString];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next])
    {
        
        NSString *fileFolderId = [rs stringForColumn:@"fileFolderId"];
        if (fileFolderId.length > 0)
        {
            [allFileFolderId addObject:fileFolderId];
        }
    }
    
    return [allFileFolderId containsObject:treePahtId];
}

//查询已下载的所有路径中是否有下级
- (BOOL)hasSubFileFolderBySuperFolderId:(NSString *) superFolderId hidenInvalid:(BOOL) hidenInvalid
{
    NSMutableArray *allFileFolderId = [NSMutableArray arrayWithCapacity:0];
    
    NSString *condationString = @"";
    if (hidenInvalid)
    {
        condationString = [NSString stringWithFormat:@"AND fileStatus <> '4'"];
        
    }
    
    
    NSString *sql = [NSString stringWithFormat:@"SELECT distinct folderTreePath FROM %@ WHERE downloadState = '%d'  %@ ",kDBTableDownLoadFileList,3,condationString];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next])
    {
        
        NSString *folderTreePath = [rs stringForColumn:@"folderTreePath"];
        if (folderTreePath.length > 0)
        {
            if ([folderTreePath containsString:superFolderId])
            {
                //如果以父节点进行分割整个路径，如果最后的值长度大于0就是有子节点
                NSArray *spertePahts = [folderTreePath componentsSeparatedByString:[NSString stringWithFormat:@"%@/",superFolderId]];
                NSString *subPathString = [spertePahts lastObject];
                if (subPathString && subPathString.length > 0)
                {
                    [allFileFolderId addObject:subPathString];
                }
            }
            
        }
    }

    return allFileFolderId.count > 0;
}


@end
