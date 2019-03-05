//
//  BaseRequest.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

+ (void)setupConfig {
    [XMCenter setupConfig:^(XMConfig *config) {
        config.generalServer = [_URLPathManager baseUrl];
        config.generalHeaders = @{@"Content‐Type": @"application/json"};
        config.generalParameters = @{@"device": @"iPhone",@"invoke":@"invoke",@"serial":[[NSUserDefaults standardUserDefaults] objectForKey:kPushClientId]};
        config.generalUserInfo = nil;
        config.callbackQueue = dispatch_get_main_queue();
        config.engine = [XMEngine sharedEngine];
        //#ifdef DEBUG
        config.consoleLog = YES;
        //#endif
    }];
}

+ (void)setServerUrl:(NSString *)serverUrl {
    [XMCenter setupConfig:^(XMConfig *config) {
        config.generalServer = serverUrl;
    }];
}

+ (void)setOpenToken:(NSString *)token {
    [XMCenter setGeneralParameterValue:token forKey:@"token"];
}



+ (NSString *)sendRequest:(RequestConfigBlock)configBlock onSuccess:(nullable SuccessBlock)successBlock onFailure:(nullable FailureBlock)failureBlock {
    NSString *requestId = [XMCenter sendRequest:configBlock onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"resultCode"] boolValue]) {
            successBlock(responseObject[@"data"]);
        } else {
            NSNumber *errorCode = responseObject[@"resultCode"];
            NSString *errorMsg = responseObject[@"resultMsg"];
            if (errorCode && errorMsg) {
                NSError *error = [NSError errorWithDomain:responseObject[@"resultMsg"]?:NetFailureErrorMsg code:[errorCode integerValue] userInfo:nil];
                failureBlock(error);
            } else {
                failureBlock([self networkError]);
            }
        }
    } onFailure:^(NSError * _Nullable error) {
        dispatch_main_safe(^{
            failureBlock([self networkError]);
        });
    }];
    
    return requestId;
}

+ (NSString *)sendPostJsonRequest:(RequestConfigBlock)configBlock onSuccess:(nullable SuccessBlock)successBlock onFailure:(nullable FailureBlock)failureBlock {
    NSString *requestId = [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        configBlock(request);
        request.requestSerializerType = kXMRequestSerializerJSON;
    } onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"resultCode"] boolValue]) {
            successBlock(responseObject[@"data"]);
        } else {
            NSNumber *errorCode = responseObject[@"resultCode"];
            NSString *errorMsg = responseObject[@"resultMsg"];
            if (errorCode && errorMsg) {
                NSError *error = [NSError errorWithDomain:responseObject[@"resultMsg"]?:NetFailureErrorMsg code:[errorCode integerValue] userInfo:nil];
                failureBlock(error);
            } else {
                failureBlock([self networkError]);
            }
        }
    } onFailure:^(NSError * _Nullable error) {
        dispatch_main_safe(^{
            failureBlock([self networkError]);
        });
    }];
    
    return requestId;
}

+ (NSError *)networkError {
    NSError *error = [NSError errorWithDomain:NetFailureErrorMsg code:400 userInfo:nil];
    return error;
}

@end
