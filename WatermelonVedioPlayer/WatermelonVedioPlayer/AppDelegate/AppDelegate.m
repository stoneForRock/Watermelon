//
//  AppDelegate.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/8.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "AppDelegate.h"

#import "GuideVC.h"
#import "APPTabbarContorller.h"
#import "MainPageVC.h"
#import "ChannelVC.h"
#import "FinderVC.h"
#import "MineVC.h"
#import "LoginVC.h"

#import "BaseRequest.h"
#import "ReachabilityManager.h"
#import "UniqueIdentificationTool.h"
#import "LaunchManager.h"
#import "AppStyle.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)getAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initAppConfigure:launchOptions];
    
    [self setupAppUI:launchOptions];
    
    [self setupAppConfigure:launchOptions];
    
    return YES;
}

//初始化应用配置
- (void)initAppConfigure:(NSDictionary *)launchOptions {
    //注册推送
    
    //保存设备唯一标识符
    if (![UniqueIdentificationTool readUIID]) {
        [UniqueIdentificationTool saveUIID];
    }
    
    //配置网络请求信息
    [BaseRequest setupConfig];
    
    //首次进入添加网络状态监听
    [[ReachabilityManager sharedManager] startMonitoring];
}

//初始化界面视图
- (void)setupAppUI:(NSDictionary *)launchOptions {
    [AppStyle setupStyple];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.tintColor = ThemeTextColor;
    [self.window makeKeyAndVisible];
    
    [LOGIN_MANAGER enterLoginWithGuideVC:NO];
    [[LaunchManager sharedLaunchManager] didFinishLaunching];
}

//配置app
- (void)setupAppConfigure:(NSDictionary *)launchOptions {
    
}

- (void)setupMainViewControllers {
    NSArray *tabbarItemInfos = @[
                                 @{@"title":@"首页",@"selectedImage":@"main_bar_mainpage_press",@"image":@"main_bar_mainpage_nopress"},
                                 @{@"title":@"频道",@"selectedImage":@"main_bar_channel_press",@"image":@"main_bar_channel_nopress"},
                                 @{@"title":@"发现",@"selectedImage":@"main_bar_discover_press",@"image":@"main_bar_discover_nopress"},
                                 @{@"title":@"我的",@"selectedImage":@"main_bar_center_press",@"image":@"main_bar_center_nopress"}
                                 ];
    NSMutableArray *tabbarNavs = [NSMutableArray arrayWithCapacity:0];
    
    MainPageVC *mainVC = [MainPageVC instanceFromXib];
    mainVC.title = @"首页";
    
    ChannelVC *channelVC = [ChannelVC instanceFromXib];
    channelVC.title = @"频道";
    
    FinderVC *finderVC = [FinderVC instanceFromXib];
    finderVC.title = @"发现";
    
    MineVC *mineVC = [MineVC instanceFromXib];
    mineVC.title = @"我的";
    
    NSArray *tabbarVCs = @[mainVC,channelVC,finderVC,mineVC];
    
    for (int i = 0; i < tabbarVCs.count; i ++) {
        if (i > tabbarItemInfos.count - 1) {
            break;
        }
        
        NSDictionary *tabbarItemInfoDic = tabbarItemInfos[i];
        UIViewController *tabbarVC = tabbarVCs[i];
        tabbarVC.tabBarItem = [[UITabBarItem alloc] init];
        tabbarVC.tabBarItem.title = tabbarItemInfoDic[@"title"];
        
        UIImage *selectedImage = [UIImage imageNamed:tabbarItemInfoDic[@"selectedImage"]];
        UIImage *image = [UIImage imageNamed:tabbarItemInfoDic[@"image"]];
        
        tabbarVC.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabbarVC.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UINavigationController *tabbarRootNav = [[UINavigationController alloc] initWithRootViewController:tabbarVC];
        [tabbarNavs addObject:tabbarRootNav];
    }
    self.tabBarController = [[APPTabbarContorller alloc] init];
    self.tabBarController.viewControllers = tabbarNavs;
    self.window.rootViewController = self.tabBarController;
}

- (void)showLoginViewControllers {
    //未登陆过，跳转到登陆页面
    LoginVC *loginVC = [LoginVC instanceFromXib];
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [[AppDelegate getAppDelegate].window.rootViewController presentViewController:loginNav animated:YES completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
