//
//  FMDBHelper+TimeTag.h
//  EDA
//
//  Created by shichuang on 16/10/17.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper.h"
#import "TimeTagModel.h"

@interface FMDBHelper (TimeTag)

#pragma mark - 创建时间标签数据库表
- (void)createTimeTagTableOnDB;

// 插入录model
- (void)insertTimeTag:(TimeTagModel *)model;
// 根据事务传入db,插入录model
- (void)insertTimeTag:(TimeTagModel *)model dataBase:(FMDatabase *)db;

//更新数据库数据
- (void)updateTimeTag:(TimeTagModel *) model;
//根据事务传入db，更新数据库数据
- (void)updateTimeTag:(TimeTagModel *) model dataBase:(FMDatabase *)db;

//查询数据库中是否存在某个场景标签
- (BOOL)hasTimeTag:(NSString *) sceneTagCode;
//根据事务传入db,查询数据库中是否存在某个时长标签
- (BOOL)hasTimeTag:(NSString *) timeTagId dataBase:(FMDatabase *)db;

//查询所有的场景标签
- (NSArray *)queryAllTimeTag;

//根据时长标签数据查询所有的时长标签
- (NSArray *)queryTimeTagModelWithTimeTagNames:(NSArray *) timeTagNames;

//根据标签编码获取标签内容
- (TimeTagModel *)queryTimeTagModelByTimeTagCode:(NSString *) timeTagCode;

@end
