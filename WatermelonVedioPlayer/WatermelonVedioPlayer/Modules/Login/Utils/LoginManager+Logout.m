//
//  LoginManager+Logout.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/18.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "LoginManager+Logout.h"
#import "LoginManager+Enter.h"

@implementation LoginManager (Logout)

- (void)signOut {
    
//    [ZNTLoginRequest logoutWithAccountNum:ZNTData_Config.user.phone userType:kUserType onSuccess:^(id  _Nullable responseObject) {
//    } onFailure:^(NSError * _Nullable error) {
//    }];
    
    [USER_Config clearConfig];
    
    [self enterLoginWithGuideVC:NO];
}

@end
