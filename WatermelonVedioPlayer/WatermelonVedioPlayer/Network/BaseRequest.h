//
//  BaseRequest.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLPathManager.h"
#import "XMNetworking.h"
#import "UserConfig.h"

#define NetFailureErrorMsg @"网络异常，请稍后再试！"

typedef XMRequestConfigBlock RequestConfigBlock;
typedef XMSuccessBlock SuccessBlock;
typedef XMFailureBlock FailureBlock;
typedef void (^RequestFinishBlock)(BOOL success, id _Nullable responseObject, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface BaseRequest : NSObject

+ (void)setupConfig;
+ (void)setServerUrl:(NSString *)serverUrl;
+ (void)setOpenToken:(NSString *)token;

+ (NSString *)sendGETRequest:(NSString *)url
                  parameters:(NSDictionary *)parameters
                    callBack:(RequestFinishBlock)callBack;

+ (NSString *)sendPOSTRequest:(NSString *)url
                   parameters:(NSDictionary *)parameters
                     callBack:(RequestFinishBlock)callBack;

+ (NSString *)sendPostJsonRequest:(NSString *)url
                       parameters:(NSDictionary *)parameters
                         callBack:(RequestFinishBlock)callBack;

+ (NSString *)sendRequest:(RequestConfigBlock)configBlock
                onSuccess:(nullable SuccessBlock)successBlock
                onFailure:(nullable FailureBlock)failureBlock;

+ (NSString *)sendPostJsonRequest:(RequestConfigBlock)configBlock
                        onSuccess:(nullable SuccessBlock)successBlock
                        onFailure:(nullable FailureBlock)failureBlock;

@end
NS_ASSUME_NONNULL_END
