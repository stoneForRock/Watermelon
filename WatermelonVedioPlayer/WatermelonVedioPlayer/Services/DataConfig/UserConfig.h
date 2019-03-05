//
//  UserConfig.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APPUser.h"

#define USER_Config [UserConfig sharedConfig]

@interface UserConfig : NSObject

//只要本地保存过就不是第一次登陆应用
@property (nonatomic, strong) APPUser *user;

//ZNTDataConfig初始化的时候数据是否可用
@property (assign, nonatomic) BOOL firstProtectedDataAvailable;

+ (UserConfig *)sharedConfig;

- (void)loadConfig;
- (void)clearConfig;
- (BOOL)saveConfig;

@end
