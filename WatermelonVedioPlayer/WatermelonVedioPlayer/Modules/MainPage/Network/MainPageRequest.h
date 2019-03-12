//
//  MainPageRequest.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/8.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "BaseRequest.h"


typedef NS_ENUM(NSInteger,ADListType) {
    ADListLaunchType = 0,//启动页广告
    ADListMainPageType = 1,//首页滚动广告
    ADListChannelType = 2,//频道广告
    ADListMineType = 3,//我的
    ADListPrePlayType = 4,//视频播放前
    ADListVideoDetialType = 5,//影片详情
    ADListOtherType = 6,//其他（视频列表穿插广告）
};

NS_ASSUME_NONNULL_BEGIN

@interface MainPageRequest : BaseRequest

/**
 获取广告

 @param listType 广告类型
 @param finishBlock finishBlock
 */
+ (void)getADListWithType:(ADListType)listType finishBlock:(RequestFinishBlock)finishBlock;

/**
 获取首页轮播图广告下方的电影分类

 @param finishBlock finishBlock
 */
+ (void)getMovieClassListFinishBlock:(RequestFinishBlock)finishBlock;

/**
 获取首页最新电影列表

 @param finishBlock finishBlock
 */
+ (void)getNewMovieListFinishBlock:(RequestFinishBlock)finishBlock;

/**
 获取首页热映电影列表

 @param finishBlock finishBlock
 */
+ (void)getHotMovieListFinishBlock:(RequestFinishBlock)finishBlock;

/**
 获取首页猜你喜欢列表

 @param finishBlock finishBlock
 */
+ (void)getGuessLikeMovieListFinishBlock:(RequestFinishBlock)finishBlock;

/**
 获取首页栏目分组列表

 @param finishBlock finishBlock
 */
+ (void)getColumnsMovieListFinishBlock:(RequestFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
