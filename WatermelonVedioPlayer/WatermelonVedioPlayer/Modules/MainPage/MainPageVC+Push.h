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

- (void)pushToMoiveClassListVCWithClassList:(NSArray *)classList currentClassInfo:(NSDictionary *)currentClassInfo;

- (void)pushToMoiveDetialVCWithMovieInfo:(MoivesModel *)movieModel;

@end

NS_ASSUME_NONNULL_END
