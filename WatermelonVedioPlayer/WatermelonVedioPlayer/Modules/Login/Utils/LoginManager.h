//
//  LoginManager.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/18.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LOGIN_MANAGER [LoginManager sharedManager]

@interface LoginManager : NSObject

+ (instancetype)sharedManager;

/**
 自动登录
 
 @param completedBlock completedBlock
 */
- (void)autoLoginCompleted:(void (^)(BOOL success, NSUInteger errorCode, NSString *error, id userInfo))completedBlock;

/**
 账号密码登录
 
 @param telephone 账号
 @param password 密码
 @param completedBlock completedBlock
 */
- (void)userLoginWithPhone:(NSString *)telephone
                  password:(NSString *)password
                 completed:(void (^)(BOOL success, NSUInteger errorCode, NSString *error, id userInfo))completedBlock;

@end
