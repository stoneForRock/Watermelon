//
//  AppDelegate.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/8.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#define APPDelegate [AppDelegate getAppDelegate]

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) CLLocationManager *locationManager;

+ (AppDelegate *)getAppDelegate;

// 进入新版指引页
- (void)showGuideVC;
- (void)setupMainViewControllers;


@end

