//
//  MoivesRequest.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MoivesRequest.h"

@implementation MoivesRequest

+ (void)requestMovieListWithSortType:(MoivesSortType)sortType classId:(NSString *)classId page:(NSString *)page finishBlock:(RequestFinishBlock)finishBlock {
    NSString *sortKey = @"";
    switch (sortType) {
        case MoivesSortMostPlay:
            sortKey = @"play_count";
            break;
        case MoivesSortMostLove:
            sortKey = @"love_cnt";
            break;
        case MoivesSortMostNew:
            sortKey = @"id";
            break;
            
        default:
            break;
    }
    [self sendPOSTRequest:@"/api/movie/list" parameters:@{@"sort":sortKey,@"clsId":classId,@"page":page,@"pageSize":@"10"} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)getColumnMoviesWithNavId:(NSString *)navId finishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/column/movies" parameters:@{@"navId":navId} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)requestMovieDetailWithMovieId:(NSString *)movieId finishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/movie/detail" parameters:@{@"id":movieId} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)getFavListFinishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/fav/list" parameters:@{} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)addFavMovieWithId:(NSString *)movieId finishBlock:(RequestFinishBlock)finishBlock {
    [self sendPOSTRequest:@"/api/fav/add" parameters:@{@"id":movieId} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)cancelFavMovieWithId:(NSString *)movieId finishBlock:(RequestFinishBlock)finishBlock {
    [self sendPOSTRequest:@"/api/fav/del" parameters:@{@"id":movieId} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)praiseMovieWithId:(NSString *)movieId status:(NSString *)status finishBlock:(RequestFinishBlock)finishBlock {
    [self sendPOSTRequest:@"/api/fav/love" parameters:@{@"id":movieId,@"status":status} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)getMovieAlikeListWithId:(NSString *)movieId finishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/movie/alike" parameters:@{@"id":movieId} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

+ (void)searchMovieWithKeyword:(NSString *)movieKeyword currentPage:(NSInteger)currentPage pageSize:(NSInteger)pageSize finishBlock:(RequestFinishBlock)finishBlock {
    [self sendGETRequest:@"/api/movie/search" parameters:@{@"page":@(currentPage),@"pageSize":@(pageSize),@"keyword":movieKeyword} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}
@end
