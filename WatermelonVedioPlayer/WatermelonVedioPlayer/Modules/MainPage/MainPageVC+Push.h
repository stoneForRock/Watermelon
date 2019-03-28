//
//  MainPageVC+Push.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MainPageVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainPageVC (Push)

/**
 点击分类Item进入列表
 
 @param currentClassId 当前类别id
 */
- (void)tapClassItemPushWithCurrentClassId:(NSString *)currentClassId;

/**
 最新片源
  */
- (void)tapMoreNewlestMovieList;

/**
 重磅热播
 */
- (void)tapHotPlayMovieList;

/**
 进入专题详情页

 @param columnModel 专题Model
 */
- (void)pushToTopicDetialMovieListWithColumn:(MovieColumnModel *)columnModel;

/**
 进入视频详情页面

 @param movieModel 视频model
 */
- (void)pushToMoiveDetialVCWithMovieInfo:(MoivesModel *)movieModel;

@end

NS_ASSUME_NONNULL_END
