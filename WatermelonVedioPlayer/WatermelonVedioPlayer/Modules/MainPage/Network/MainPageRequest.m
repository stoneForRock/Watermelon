//
//  MainPageRequest.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/8.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MainPageRequest.h"

@implementation MainPageRequest

+ (void)getADListWithType:(ADListType)listType finishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/ads" parameters:@{@"location":@(listType)} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)getMovieClassListFinishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/movie-class/list" parameters:@{} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)getNewMovieListFinishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/home/newmov" parameters:@{} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)getHotMovieListFinishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/home/hotmov" parameters:@{} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)getGuessLikeMovieListFinishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/home/guess-like" parameters:@{} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)getColumnsMovieListFinishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/home/columns" parameters:@{} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

@end
