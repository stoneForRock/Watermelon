//
//  FMDBHelper+CoustomDATag.h
//  EDA
//
//  Created by shichuang on 16/10/20.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper.h"

@interface FMDBHelper (CoustomDATag)

#pragma mark - 创建自定义标签数据库表
- (void)createCoustomTagTableOnDB;

// 插入自定义标签
- (void)insertCoustomTag:(NSString *) tag;

//更新数据库数据
- (void)updateCoustomTag:(NSString *) tag;

//查询数据库中是否存在某个自定义标签
- (BOOL)hasCoustomTag:(NSString *) tag;

//删除某个自定义标签
- (void)deleteCustomTag:(NSString *) tag;

//查询所有的自定义标签
- (NSArray *)queryAllCoustomTag;

//根据标签名称数组查询自定义标签model
- (NSArray *)queryCoustomTagsWithCoustomNames:(NSArray *) coustomNames;

//删除所有自定义标签
- (void)deleteAllCoustomTag;

@end
