//
//  FMDBHelper+FolderTree.h
//  EDA
//
//  Created by shichuang on 16/10/17.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper.h"
#import "FolderTreeModel.h"

@interface FMDBHelper (FolderTree)

#pragma mark - 创建文件夹目录数据库表
- (void)createFileFolderTreeTableOnDB;

// 插入文件夹目录model
- (void)insertFileFolderTree:(FolderTreeModel *)model;
// 更具事务传入db,插入文件夹目录model
- (void)insertFileFolderTree:(FolderTreeModel *)model dataBase:(FMDatabase *)db;

//更新数据库数据
- (void)updateFileFolderTree:(FolderTreeModel *) model;

//根据事务传入的db 更新数据库数据
- (void)updateFileFolderTree:(FolderTreeModel *) model dataBase:(FMDatabase *)db;

//查询数据库中是否存在某个文件夹目录
- (BOOL)hasFileFolderTree:(NSString *) folderId;
//根据事务传入db，查询数据库中是否存在某个文件夹目录
- (BOOL)hasFileFolderTree:(NSString *) folderId dataBase:(FMDatabase *)db;

//查询下一层的子model
- (NSArray *)querySubListModelWithParentModel:(FolderTreeModel *) model hasDAFile:(BOOL) hasDAFile;

//获取根目录model
- (FolderTreeModel *)getRootModel;

//获取根目录下文件
- (NSArray *)queryRootListModelHasDAFile:(BOOL) hasDAFile;

//根据文件夹路径更新，是否含有DA文件字段,用来在演示路径查找DA中是否显示
- (void)updateFileFolderTreeHasDAFileStatus:(BOOL) hasDAFile folderId:(NSString *) folderId;

//删除所有DA文件的时候，需要把所有的有DA字段改为NO
- (void)changeAllTreeFolderHasDAFileStatusToNO;

//根据文件夹目录Id获取目录对象
- (FolderTreeModel *)getFolderTreeModelWithFolderId:(NSString *) folderId;

//查询所有的组织树
- (NSArray *)queryAllFolderTree;

//通过事务传入db 查询所有的组织树
- (NSArray *)queryAllFolderTreeWithDataBase:(FMDatabase *)db;

//获取所有父节点id
- (NSArray *)quertAllFolderParentId;

//通过事务传入db  获取所有父节点id
- (NSArray *)quertAllFolderParentIdWithDataBase:(FMDatabase *)db;

@end
