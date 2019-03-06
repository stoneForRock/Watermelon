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
        
        //没有token 请求获取token
        //获取token后 再开始倒计时 倒计时完成后 进入主页
        
        //未登陆过，跳转到登陆页面
        LoginVC *loginVC = [LoginVC instanceFromXib];
        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [AppDelegate getAppDelegate].window.rootViewController = loginNav;
    }
}

- (void)directEnterAPP {
    //执行进入应用主页面之前的逻辑，比如数据库的初始化
    
    //自动登录接口
    [self autoLoginCompleted:^(BOOL success, NSUInteger errorCode, NSString *error, id userInfo) {
    }];
    [self enterMainViewController];
}


@end
