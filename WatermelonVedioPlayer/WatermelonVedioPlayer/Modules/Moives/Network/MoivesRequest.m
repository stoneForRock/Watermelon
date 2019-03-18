//
//  MoivesRequest.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MoivesRequest.h"

@implementation MoivesRequest

+ (void)requestMovieListWithSort:(NSString *)sortKey classId:(NSString *)classId page:(NSString *)page finishBlock:(RequestFinishBlock)finishBlock {
    [self sendPOSTRequest:@"/api/movie-class/list" parameters:@{@"sort":sortKey,@"clsId":classId,@"page":page,@"pageSize":@"10"} callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

@end
