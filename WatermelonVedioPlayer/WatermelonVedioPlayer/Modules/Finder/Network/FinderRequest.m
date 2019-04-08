//
//  FinderRequest.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/8.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "FinderRequest.h"

@implementation FinderRequest

+ (void)requestDiscoverListWithPage:(NSInteger)page finishBlock:(RequestFinishBlock)finishBlock {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    if (page) {
        [params setObject:@(page) forKey:@"page"];
    }
    [params setObject:@"10" forKey:@"pageSize"];
    [self sendGETRequest:@"/api/movie/discover" parameters:params.copy callBack:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        finishBlock(success,responseObject,error);
    }];
}

@end
