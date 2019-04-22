//
//  ChannelRequest.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/8.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChannelRequest : BaseRequest

/**
 获取专栏页面下的栏目小分类集合

 @param finishBlock finishBlock
 */
+ (void)getColumnNavsFinishBlock:(RequestFinishBlock)finishBlock;

/**
 获取专栏页栏目详情电影列表

 @param navId 栏目ID
 @param finishBlock finishBlock
 */
+ (void)getColumnMovieListWithNavsId:(NSString *)navId finishBlock:(RequestFinishBlock)finishBlock;

/**
 获取频道标签列表

 @param finishBlock finishBlock
 */
+ (void)getTagListFinishBlock:(RequestFinishBlock)finishBlock;

/**
 根据标签查询电影

 @param tagIds 标签列表
 @param page 当前页
 @param finishBlock finishBlock
 */
+ (void)queryMovieWithTagIds:(NSArray *)tagIds page:(NSInteger)page finishBlock:(RequestFinishBlock)finishBlock;

/**
 获取演员分类列表

 @param finishBlock finishBlock
 */
+ (void)getActorCategoriesFinishBlock:(RequestFinishBlock)finishBlock;

/**
 演员列表

 @param categoryId 演员分类id
 @param sort sort – 排序类型（可选值movie_count 影片量, play_count 人气，默认 play_count）
 @param finishBlock finishBlock
 */
+ (void)getActorListWithCategoryId:(NSString *)categoryId sort:(NSString *)sort finishBlock:(RequestFinishBlock)finishBlock;

/**
 获取所有的人气演员

 @param finishBlock finishBlock
 */
+ (void)getHotsActorFinishBlock:(RequestFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
