//
//  MainPageVC+Request.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MainPageVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainPageVC (Request)

- (void)lunchRequest;

- (void)requestMainPageData;

- (void)requestHotPlayMovieWithPageNum:(NSString *)pageNum;

@end

NS_ASSUME_NONNULL_END
