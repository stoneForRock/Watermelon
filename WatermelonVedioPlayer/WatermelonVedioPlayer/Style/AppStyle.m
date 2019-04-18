//
//  AppStyle.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "AppStyle.h"
#import "IQKeyboardManager.h"

@implementation AppStyle

+ (void)setupStyple {
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    //setup status bar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    //setup nav
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setBackgroundColor:COLORWITHRGBADIVIDE255(49, 49, 49, 1)];
    [[UINavigationBar appearance] setTintColor:COLORWITHRGBADIVIDE255(194, 154, 104, 1)];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeTextColor, NSFontAttributeName : [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName : [ThemeTextColor colorWithAlphaComponent:0.5], NSFontAttributeName : [UIFont systemFontOfSize:14]} forState:UIControlStateHighlighted];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setBackButtonTitlePositionAdjustment:UIOffsetMake(3, 0) forBarMetrics:UIBarMetricsDefault];
    
    UIImage *image = [UIImage imageNamed:@"nav_back"];
    [[UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil] setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width-1, image.size.height/2-1, image.size.width)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil] setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width-1, image.size.height/2-1, image.size.width)] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setBackIndicatorImage:image];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:image];
    UIBarButtonItem *buttonItem = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    UIOffset offset;
    offset.horizontal = -500;
    [buttonItem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
    
    
    [[UITabBar appearance] setBarTintColor:COLORWITHRGBADIVIDE255(49, 49, 49, 1)];
    [UITabBar appearance].translucent = NO;
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : COLORWITHRGBADIVIDE255(107, 107, 107, 1), NSFontAttributeName : [UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : COLORWITHRGBADIVIDE255(194, 154, 104, 1), NSFontAttributeName : [UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
    
    
    //setup searchbar
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];
    [[UISearchBar appearance] setBarTintColor:COLORWITHRGBADIVIDE255(194, 154, 104, 1)];
    [[UISearchBar appearance] setBarStyle:UIBarStyleBlack];
    [[UISearchBar appearance] setBackgroundImage:[UIImage sc_imageWithColor:COLORWITHRGBADIVIDE255(30, 30, 30, 1.0)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"search"]forSearchBarIcon:UISearchBarIconSearch state:UIControlStateHighlighted];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : COLORWITHRGBADIVIDE255(151, 151, 151, 1.0)}];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName:COLORWITHRGBADIVIDE255(151, 151, 151, 1.0)} forState:UIControlStateNormal];
    
    //UITextField的光标颜色可以用这个控制
    [[UITextField appearance] setTintColor:COLORWITHRGBADIVIDE255(194, 154, 104, 1)];
    
}

@end
