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

- (void)pushToMoiveDetialVCWithMovieInfo:(MoivesModel *)movieModel;

@end

NS_ASSUME_NONNULL_END
