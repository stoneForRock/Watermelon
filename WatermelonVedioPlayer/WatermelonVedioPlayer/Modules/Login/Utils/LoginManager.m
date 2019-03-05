//
//  LoginManager.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/18.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "LoginManager.h"
#import "LoginManager+Enter.h"

@implementation LoginManager

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (id)sharedManager {
    
    static LoginManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LoginManager alloc] init];
    });
    return sharedInstance;
}

- (void)autoLoginCompleted:(void (^)(BOOL success, NSUInteger errorCode, NSString *error, id userInfo))completedBlock {
}

- (void)userLoginWithPhone:(NSString *)telephone
                  password:(NSString *)password
                 completed:(void (^)(BOOL success, NSUInteger errorCode, NSString *error, id userInfo))completedBlock {
//    [LoginRequest loginWithPhone:telephone password:password userType:kUserType onSuccess:^(id  _Nullable responseObject) {
//
//        if (completedBlock) {
//            completedBlock(YES,0,nil,nil);
//        }
//        //登录成功，存储用户信息
//        APPUser *user = [[ZNTUser alloc] initWithDictionary:responseObject error:nil];
//        [ZNTDataConfig sharedConfig].user = user;
//        [[ZNTDataConfig sharedConfig] saveConfig];
//
//        //更新请求token
//        [ZNTRequest setOpenToken:user.token];
//
//        [self enterMainViewController];
//
//    } onFailure:^(NSError * _Nullable error) {
//        if (completedBlock) {
//            completedBlock(NO,1,error.domain,nil);
//        }
//    }];
}

@end
