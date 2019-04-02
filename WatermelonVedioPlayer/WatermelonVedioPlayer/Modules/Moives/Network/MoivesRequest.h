//
//  MoivesRequest.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,MoivesSortType) {
    MoivesSortSynthesize = 0,      //综合
    MoivesSortMostPlay,     //最多播放
    MoivesSortMostNew,     //最近更新
    MoivesSortMostLove,    //最多喜欢
};

@interface MoivesRequest : BaseRequest

/**
 获取电影分类下的列表

 @param sortType 排序类型：play_count - 最多播放，love_cnt - 最多喜欢，id - 最近更新，为空则为综合排序
 @param classId 影片分类
 @param page 当前页 1开始
 @param finishBlock finishBlock
 */
+ (void)requestMovieListWithSortType:(MoivesSortType)sortType classId:(NSString *)classId page:(NSString *)page finishBlock:(RequestFinishBlock)finishBlock;

/**
 获取专栏页栏目详情电影列表

 @param navId 栏目id
 @param finishBlock finishBlock
 */
+ (void)getColumnMoviesWithNavId:(NSString *)navId finishBlock:(RequestFinishBlock)finishBlock;

/**
 获取影片详情

 @param movieId 影片id
 @param finishBlock finishBlock
 */
+ (void)requestMovieDetailWithMovieId:(NSString *)movieId finishBlock:(RequestFinishBlock)finishBlock;

/**
 获取收藏影片列表

 @param finishBlock finishBlock
 */
+ (void)getFavListFinishBlock:(RequestFinishBlock)finishBlock;

/**
 添加收藏

 @param movieId 电影id
 @param finishBlock finishBlock
 */
+ (void)addFavMovieWithId:(NSString *)movieId finishBlock:(RequestFinishBlock)finishBlock;

/**
 取消收藏

 @param movieId 影片id
 @param finishBlock finishBlock
 */
+ (void)cancelFavMovieWithId:(NSString *)movieId finishBlock:(RequestFinishBlock)finishBlock;

/**
 赞、踩-影片
 注：赞或踩之后不能取消/切换
 @param movieId 影片id
 @param status 类型[1 - 赞，2 - 踩]
 @param finishBlock finishBlock
 */
+ (void)praiseMovieWithId:(NSString *)movieId status:(NSString *)status finishBlock:(RequestFinishBlock)finishBlock;

/**
 获取影片详情关联相似影片列表

 @param movieId movieId
 @param finishBlock finishBlock
 */
+ (void)getMovieAlikeListWithId:(NSString *)movieId finishBlock:(RequestFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
