//
//  MainPageVC+Request.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MainPageVC+Request.h"
#import "MainPageRequest.h"
#import "LoginRequest.h"
#import "UniqueIdentificationTool.h"
#import "LaunchManager.h"
#import "AppDelegate.h"

@implementation MainPageVC (Request)

- (void)lunchRequest {
    [APPDelegate.window showHUDLoadingText:@"正在选择加速通道,请稍候..."];
    [LoginRequest getVisitorTokenWithDeviceUIID:[UniqueIdentificationTool readUIID] finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        [APPDelegate.window hideHUDView];
        if (success) {
            //获取到游客token
            NSString *visitorToken = responseObject;
            USER_Config.user.visitorToken = visitorToken;
            [USER_Config saveConfig];
            [self requestLuanchAdsRequest];
            [self requestMainPageTopAds];
            [self requestMainMoiveClass];
            [self requestNewestMoive];
            [self requestHotPlayMovie];
            [self requestMovieListAd];
        } else {
            [APPDelegate.window showHUDWithErrorText:error.domain];
            [self lunchRequest];
        }
    }];
}

//获取启动页广告
- (void)requestLuanchAdsRequest {
    [MainPageRequest getADListWithType:ADListLaunchType finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            [[LaunchManager sharedLaunchManager] showTimeOutCountWithAds:responseObject];
        } else {
            [[LaunchManager sharedLaunchManager] showTimeOutCountWithAds:@[]];
        }
    }];
}

//获取主页广告
- (void)requestMainPageTopAds {
    [MainPageRequest getADListWithType:ADListMainPageType finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            [self initTopScrollWithData:responseObject];
        }
    }];
}

- (void)requestMainMoiveClass {
    [MainPageRequest getMovieClassListFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            [self refreshMoiveClassWithClass:responseObject];
        }
    }];
}

- (void)requestNewestMoive {
    [MainPageRequest getNewMovieListFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            [self refreshNewestMoiveWithList:responseObject];
        }
    }];
}

- (void)requestHotPlayMovie {
    [MainPageRequest getHotMovieListFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            [self refreshHotPlayMoiveWithList:responseObject];
        }
    }];
}

- (void)requestGuessLikeMovie {
    [MainPageRequest getGuessLikeMovieListFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            
        }
    }];
}

- (void)requestMovieListAd {
    [MainPageRequest getADListWithType:ADListOtherType finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
}

@end
