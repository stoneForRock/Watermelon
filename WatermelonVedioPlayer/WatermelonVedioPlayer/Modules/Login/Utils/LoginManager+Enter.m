//
//  LoginManager+Enter.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/18.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "LoginManager+Enter.h"
#import "LoginVC.h"
#import "AppDelegate.h"
#import "LoginRequest.h"
#import "UniqueIdentificationTool.h"
#import "LaunchManager.h"

@implementation LoginManager (Enter)

- (void)enterMainViewController {
    [[AppDelegate getAppDelegate] setupMainViewControllers];
}

- (void)enterLoginWithGuideVC:(BOOL)showGuideVC {
    //如果已经有token，就直接进入主页
    if (USER_Config.user.token.length > 0) {
        [self directEnterAPP];
        return;
    }
    
    if (showGuideVC) {
        //跳转到引导页面
        
    } else {
        
        //没有visitorToken 请求获取visitorToken
        if (USER_Config.user.visitorToken.length > 0) {
            //进入主页
            [self directEnterAPP];
        } else {
            [self directEnterAPP];
            [APPDelegate.window showHUDLoadingText:@"选择加速通道..."];
            [LoginRequest getVisitorTokenWithDeviceUIID:[UniqueIdentificationTool readUIID] finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
                [APPDelegate.window hideHUDView];
                if (success) {
                    //获取到游客token
                    NSString *visitorToken = responseObject[@"data"];
                    USER_Config.user.visitorToken = visitorToken;
                    [USER_Config saveConfig];
                    [LaunchManager showTimeOutCount];
                } else {
                    [APPDelegate.window showHUDWithErrorText:error.domain];
                }
            }];
        }
    }
}

- (void)directEnterAPP {
    //执行进入应用主页面之前的逻辑，比如数据库的初始化
    
    [self enterMainViewController];
}


@end
