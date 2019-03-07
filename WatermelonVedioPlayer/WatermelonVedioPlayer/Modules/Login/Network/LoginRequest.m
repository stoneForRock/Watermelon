//
//  LoginRequest.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/18.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "LoginRequest.h"
#import "NSString+MD5.h"
@implementation LoginRequest

+ (void)getVisitorTokenWithDeviceUIID:(NSString *)uiid finishBlock:(RequestFinishBlock)finishBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/api/auth/visitor";
        NSString *sign = [[[uiid MD5] substringWithRange:NSMakeRange(0, 16)] MD5];
        request.parameters = @{@"key":uiid,@"sign":sign};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        finishBlock(YES,responseObject,nil);        
    } onFailure:^(NSError * _Nullable error) {
        finishBlock(NO,nil,error);
    }];
}

@end
