//
//  LoginManager+Enter.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/18.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "LoginManager+Enter.h"
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
        [self directEnterAPP];
    }
}

- (void)directEnterAPP {
    //执行进入应用主页面之前的逻辑，比如数据库的初始化
    
    [self enterMainViewController];
}


@end
