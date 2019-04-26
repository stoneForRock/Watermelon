//
//  FMDBHelper+SceneTag.h
//  EDA
//
//  Created by shichuang on 16/10/17.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper.h"
#import "SceneTagModel.h"

@interface FMDBHelper (SceneTag)

#pragma mark - 创建场景标签数据库表
- (void)createSceneTagTableOnDB;


// 插入录model
- (void)insertSceneTag:(SceneTagModel *)model;
//根据事务传入db 插入文件夹目录model
- (void)insertSceneTag:(SceneTagModel *)model dataBase:(FMDatabase *)db;

//更新数据库数据
- (void)updateSceneTag:(SceneTagModel *) model;
//传入事务db,更新数据库数据
- (void)updateSceneTag:(SceneTagModel *) model dataBase:(FMDatabase *)db;

//查询数据库中是否存在某个场景标签
- (BOOL)hasSceneTag:(NSString *) sceneTagId;
//传入事务db 查询数据库中是否存在某个场景标签
- (BOOL)hasSceneTag:(NSString *)sceneTagId dataBase:(FMDatabase *)db;

//查询所有的场景标签
- (NSArray *)queryAllSceneTag;

//根据场景名称获取场景组model
- (SceneTagModel *)querySceneModelWithSceneName:(NSString *) sceneName;

//根据场景组id获取所有场景标签
- (NSArray *)querySceneTagByGroupId:(NSString *) groupId;

//根据场景组id和已存在的标签名称来获取场景标签
- (NSArray *)querySceneTagModelWithGroupId:(NSString *) groupId sceneNames:(NSArray *) sceneNames;

//根据标签编码获取标签内容
- (SceneTagModel *)querySceneTagModelBySceneTagId:(NSString *) sceneTagId;

//获取所有场景组信息
- (NSArray<NSDictionary *> *)quertAllSceneGroup;

//根据场景名称查询所有场景组
- (NSArray<NSDictionary *>  *)querySceneGroupWithSceneNames:(NSArray *) sceneNames;

@end
