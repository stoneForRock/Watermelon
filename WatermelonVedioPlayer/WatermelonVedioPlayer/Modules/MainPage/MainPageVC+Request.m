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
#import "MoivesModel.h"

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
            [self requestMainPageData];
        } else {
            [APPDelegate.window showHUDWithErrorText:error.domain];
            [self lunchRequest];
        }
    }];
}

- (void)requestMainPageData {
    [self requestMainPageTopAds];
    [self requestMainMoiveClass];
    [self requestNewestMoive];
    [self requestHotPlayMovie];
    [self requestGuessLikeMovie];
    [self requestMovieListAd];
    [self requestColumnsMovieList];
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
            NSMutableArray *movies = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *movieDic in responseObject[@"data"]) {
                MoivesModel *model = [[MoivesModel alloc] initWithDictionary:movieDic error:nil];
                [movies addObject:model];
            }
            [self refreshNewestMoiveWithList:movies.copy];
        }
    }];
}

- (void)requestHotPlayMovie {
    [self requestHotPlayMovieWithPageNum:@"1"];
}

- (void)requestHotPlayMovieWithPageNum:(NSString *)pageNum  {
    [MainPageRequest getHotMovieListWithPageNum:pageNum finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            NSMutableArray *movies = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *movieDic in responseObject[@"data"]) {
                MoivesModel *model = [[MoivesModel alloc] initWithDictionary:movieDic error:nil];
                [movies addObject:model];
            }
            [self refreshHotPlayMoiveWithList:movies.copy pageNum:responseObject[@"pageNum"] pages:responseObject[@"pages"]];
        }
    }];
}

- (void)requestGuessLikeMovie {
    [MainPageRequest getGuessLikeMovieListFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            NSMutableArray *movies = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *movieDic in responseObject) {
                MoivesModel *model = [[MoivesModel alloc] initWithDictionary:movieDic error:nil];
                [movies addObject:model];
            }
            [self refreshGussLikeMoiveWithList:movies.copy];
        }
    }];
}

- (void)requestMovieListAd {
    [MainPageRequest getADListWithType:ADListOtherType finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        [self refreshMovieListADWithADList:responseObject];
    }];
}

- (void)requestColumnsMovieList {
    [MainPageRequest getColumnsMovieListFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            NSMutableArray *movieColumns = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *movieColumnDic in responseObject) {
                MovieColumnModel *movieColumnModel = [[MovieColumnModel alloc] initWithDictionary:movieColumnDic error:nil];
                [movieColumns addObject:movieColumnModel];
            }
            [self refreshColumnList:movieColumns.copy];
        }
    }];
}

@end
