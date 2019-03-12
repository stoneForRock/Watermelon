//
//  BaseRequest.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "BaseRequest.h"
#import "NSString+MD5.h"
#import "UniqueIdentificationTool.h"
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

+ (NSString *)sendGETRequest:(NSString *)url
                  parameters:(NSDictionary *)parameters
                    callBack:(RequestFinishBlock)callBack{
    return [self sendRequest:url parameters:parameters isPost:NO timeoutInterval:0 retryCount:0 callBack:callBack];
}

+ (NSString *)sendPOSTRequest:(NSString *)url
                   parameters:(NSDictionary *)parameters
                     callBack:(RequestFinishBlock)callBack{
    return [self sendRequest:url parameters:parameters isPost:YES timeoutInterval:0 retryCount:0 callBack:callBack];
}

+ (NSString *)sendRequest:(NSString *)url
               parameters:(NSDictionary *)parameters
                   isPost:(BOOL)isPost
          timeoutInterval:(NSTimeInterval)timeoutInterval
               retryCount:(NSUInteger)retryCount
                 callBack:(RequestFinishBlock)callBack
{
    return [self sendBaseRequest:url parameters:parameters isPost:isPost isJson:NO timeoutInterval:timeoutInterval retryCount:retryCount callBack:callBack];
}

+ (NSString *)sendBaseRequest:(NSString *)url
                   parameters:(NSDictionary *)parameters
                       isPost:(BOOL)isPost
                       isJson:(BOOL)isJson
              timeoutInterval:(NSTimeInterval)timeoutInterval
                   retryCount:(NSUInteger)retryCount
                     callBack:(RequestFinishBlock)callBack
{
    return [XMCenter sendRequest:^(XMRequest *request) {
        request.api = url;
        request.parameters = parameters;
        request.retryCount = retryCount;
        request.headers = @{@"token":[USER_Config.user getRequestToken],@"Content‐Type": @"application/json"};
        request.timeoutInterval = timeoutInterval;
        request.httpMethod = isPost?kXMHTTPMethodPOST:kXMHTTPMethodGET;
        request.requestSerializerType = isJson?kXMRequestSerializerJSON:kXMRequestSerializerRAW;
        
    } onSuccess:^(id responseObject) {
        if ([responseObject[@"success"] boolValue]) {
            callBack(YES,responseObject[@"data"],nil);
        } else {
            NSNumber *errorCode = responseObject[@"code"];
            NSString *errorMsg = responseObject[@"msg"];
            if (errorCode && errorMsg) {
                if ([errorCode integerValue] == 401) {
                    [self getVisitorToken];
                    callBack(NO,nil,[self networkError]);
                } else {
                    NSError *error = [NSError errorWithDomain:errorMsg?:NetFailureErrorMsg code:[errorCode integerValue] userInfo:nil];
                    callBack(NO,responseObject[@"data"],error);
                }
            } else {
                callBack(NO,nil,[self networkError]);
            }
        }
    } onFailure:^(NSError *error) {
        dispatch_main_safe(^{
            callBack(NO,nil,[self networkError]);
        });
    }];
}

+ (NSString *)sendRequest:(RequestConfigBlock)configBlock onSuccess:(nullable SuccessBlock)successBlock onFailure:(nullable FailureBlock)failureBlock {
    NSString *requestId = [XMCenter sendRequest:configBlock onSuccess:^(id  _Nullable responseObject) {
        if ([responseObject[@"success"] boolValue]) {
            successBlock(responseObject[@"data"]);
        } else {
            NSNumber *errorCode = responseObject[@"code"];
            NSString *errorMsg = responseObject[@"msg"];
            if (errorCode && errorMsg) {
                if ([errorCode integerValue] == 401) {
                    [self getVisitorToken];
                    failureBlock([self networkError]);
                } else {
                    NSError *error = [NSError errorWithDomain:errorMsg?:NetFailureErrorMsg code:[errorCode integerValue] userInfo:nil];
                    failureBlock(error);
                }
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
        if ([responseObject[@"success"] boolValue]) {
            successBlock(responseObject[@"data"]);
        } else {
            NSNumber *errorCode = responseObject[@"code"];
            NSString *errorMsg = responseObject[@"msg"];
            if (errorCode && errorMsg) {
                if ([errorCode integerValue] == 401) {
                    [self getVisitorToken];
                    failureBlock([self networkError]);
                } else {
                    NSError *error = [NSError errorWithDomain:errorMsg?:NetFailureErrorMsg code:[errorCode integerValue] userInfo:nil];
                    failureBlock(error);
                }
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

+ (void)getVisitorToken {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/api/auth/visitor";
        NSString *uiid = [UniqueIdentificationTool readUIID];
        NSString *sign = [[[uiid MD5] substringWithRange:NSMakeRange(0, 16)] MD5];
        request.parameters = @{@"key":uiid,@"sign":sign};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        NSString *visitorToken = responseObject;
        USER_Config.user.visitorToken = visitorToken;
        [USER_Config saveConfig];
    } onFailure:^(NSError * _Nullable error) {
    }];
}

+ (NSError *)networkError {
    NSError *error = [NSError errorWithDomain:NetFailureErrorMsg code:400 userInfo:nil];
    return error;
}

@end
