//
//  ChannelRequest.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/8.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "ChannelRequest.h"

@implementation ChannelRequest

+ (void)getColumnNavsFinishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/column/navs" parameters:@{} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)getColumnMovieListWithNavsId:(NSString *)navId finishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/column/movies" parameters:@{@"navId":navId} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)getTagListFinishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/tag/list" parameters:@{} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)queryMovieWithTagIds:(NSArray *)tagIds page:(NSInteger)page finishBlock:(RequestFinishBlock)finishBlock {
    [self sendPostJsonRequest:@"/api/movie/bytags" parameters:@{@"tagIds":tagIds,@"page":@(page),@"pageSize":@"10"} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)getActorCategoriesFinishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/actor/categories" parameters:@{} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)getActorListWithCategoryId:(NSString *)categoryId sort:(NSString *)sort finishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/actor/list" parameters:@{@"categoryId":categoryId,@"sort":sort} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)getHotsActorFinishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/actor/hots" parameters:@{} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

@end
