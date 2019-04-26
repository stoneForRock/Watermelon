//
//  FMDBHelper+CloudData.h
//  EDA
//
//  Created by shichuang on 16/10/17.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper.h"
#import "CloudDataModel.h"
#import "FMDBHelper+FolderTree.h"

@interface FMDBHelper (CloudData)

#pragma mark - 创建下载文件数据库表
- (void)createDownLoadFileTableOnDB;


// 插入下载文件数据   当开始点击下载时就会插入数据库
- (void)insertCloudData:(CloudDataModel *)model;
// 根据事务传入db,插入下载文件数据   当开始点击下载时就会插入数据库
- (void)insertCloudData:(CloudDataModel *)model dataBase:(FMDatabase *)db;

//对da进行更新
- (void)updateCloudDataInfoWithCloudData:(CloudDataModel *) model;

//更新记录最后演示时间
- (void)updateFileDisplayLastTime:(CloudDataModel *) model;

//更新文件状态
- (void)updateCloudDataStateWithCloudData:(CloudDataModel *) model;

//更新文件下载完成时间，用来在已下载中进行排序
- (void)updateCloudDataDownloadTimeWithCloudData:(CloudDataModel *) model;

//更新文件是否已解压状态
- (void)updateCloudDataZipStatus:(CloudDataModel *) model;

//清除缓存时，把所有解压状态修改为未解压
- (void)updateAllCloudDataZipStatus;

//删除某条数据
- (void)deleteCloudData:(CloudDataModel *) model;

//根据fileID查询数据库中的model
- (CloudDataModel *)queryCloudDataModelWithFileId:(NSString *) fileId;
//根据事务传入db，根据fileID查询数据库中的model
- (CloudDataModel *)queryCloudDataModelWithFileId:(NSString *) fileId dataBase:(FMDatabase *)db;

//查询所有已下载完成的DA文件
- (NSMutableArray *)queryAllDownloadedDA;

//根据是否显示已作废来过滤所有已下载完成的DA
- (NSMutableArray *)queryAllDownloadedDAHidenInvalid:(BOOL) hidenInvalid;

//查询某个文件夹路径下的DA文件
- (NSMutableArray *)queryDownloadDAWithFileFolderId:(NSString *) fileFolderId;

//查询数据库中是否存在某个文件
- (BOOL)hasDownloadFile:(NSString *) fileId;
//根据传入事务，查询数据库中是否存在某个文件
- (BOOL)hasDownloadFile:(NSString *) fileId dataBase:(FMDatabase *)db;

//查询未下载完成的所有文件
- (NSMutableArray *)queryDownloadingDAFile;

//查询正在等待下载的所有文件
- (NSMutableArray *)queryWaitDownloadDAFile;

//查询所有在下载队列中的所有文件
- (NSMutableArray *)queryDownloadQueueListModel;

//查询正在下载中界面过滤数据，包括目录，场景
- (NSMutableArray *)queryFilterDownloadingDAFileWithFolderId:(NSString *) folderId
                                                    sceneTag:(NSString *) sceneTag;

//查询已下载界面过滤数据，包括目录，场景，DA标签 和关键字搜索
- (NSMutableArray *)queryFilterDownloadDAFileWithFolderId:(NSString *) folderId
                                                 sceneTag:(NSString *) sceneTag
                                             coustomDATag:(NSString *) coustomDATag
                                                searchKey:(NSString *) searchKey;

//删除资料库的所有数据
- (void)deleteAllCloudData;

//查询某个路径下DA文件所有的场景标签 名称
- (NSMutableArray *)querySceneTagFromDAFileWithFileFolderId:(NSString *) fileFolderId;

//查询所有已下载DA的场景名称
- (NSMutableArray *)queryAllDownloadedDASceneTagHidenInvalid:(BOOL) hidenInvalid;

//查询某个路径下DA文件所有的时长标签 名称
- (NSMutableArray *)queryTimeTagFromDAFileWithFileFolderId:(NSString *) fileFolderId;

//查询某个路径下DA文件所有的自定义标签名称
- (NSMutableArray *)queryCustomTagFromDAFileWithFileFolderId:(NSString *) fileFolderId;

//查询所有已下载DA文件的所有自定义标签
- (NSArray *)queryAllCustomTagFromDownloadDAFile;


//根据演示路径多选条件对已下载界面进行数据过滤
- (NSMutableArray *)queryFilterDownLoadDAFileWithFolderId:(NSString *) folderId
                                                sceneTags:(NSArray *) sceneTags
                                                 timeTags:(NSArray *) timeTags
                                              coustomTags:(NSArray *) coustomTags
                                              updateTimes:(NSArray *) updateTimes
                                                searchKey:(NSString *) searchKey;

//根据父文件夹路径取下一层文件夹路径
- (NSArray<FolderTreeModel *> *)getNextFileFolderBySuperFileFolderId:(NSString *) superFileFolderId hidenInvalid:(BOOL) hidenInvalid;

//获取所有已下载的fileFolderPath根目录
- (NSArray<FolderTreeModel *> *)getRootFileFolderForAllDownloadedFileWithHidenInvalid:(BOOL) hidenInvalid;

//判断某个目录下是否有DA文件 如果数据库中有DA的文件对应过去 就是有，没有对应过去 就没有
- (BOOL)hasDAFileInTreePath:(NSString *) treePahtId  hidenInvalid:(BOOL) hidenInvalid;

//查询已下载的所有路径中是否有下级
- (BOOL)hasSubFileFolderBySuperFolderId:(NSString *) superFolderId hidenInvalid:(BOOL) hidenInvalid;

@end
