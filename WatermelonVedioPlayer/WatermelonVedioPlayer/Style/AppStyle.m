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
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeTextColor, NSFontAttributeName : [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName : [ThemeTextColor colorWithAlphaComponent:0.5], NSFontAttributeName : [UIFont systemFontOfSize:14]} forState:UIControlStateHighlighted];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setBackButtonTitlePositionAdjustment:UIOffsetMake(3, 0) forBarMetrics:UIBarMetricsDefault];
    
    UIImage *image = [UIImage imageNamed:@"nav_btn_back_light_normal"];
    [[UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil] setBackButtonBackgroundImage:[[UIImage imageNamed:@"nav_btn_back_light_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width-1, image.size.height/2-1, image.size.width)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil] setBackButtonBackgroundImage:[[UIImage imageNamed:@"nav_btn_back_light_press"] resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width-1, image.size.height/2-1, image.size.width)] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    
    [[UITabBar appearance] setBarTintColor:COLORWITHRGBADIVIDE255(49, 49, 49, 1)];
    [UITabBar appearance].translucent = NO;
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : COLORWITHRGBADIVIDE255(194, 154, 104, 1), NSFontAttributeName : [UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : COLORWITHRGBADIVIDE255(139, 54, 55, 1), NSFontAttributeName : [UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
    
    
    //setup searchbar
    [[UISearchBar appearance] setBarTintColor:[UIColor themeBackgroundColor]];
    [[UISearchBar appearance] setBarStyle:UIBarStyleBlack];
    [[UISearchBar appearance] setBackgroundImage:[UIImage sc_imageWithColor:ThemeColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"search_bar_btn_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"search_bar_btn_search_highlight"]forSearchBarIcon:UISearchBarIconSearch state:UIControlStateHighlighted];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"search_bar_btn_clear"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    UIImage *backgroundImage = [UIImage imageNamed:@"search_bar_textfield"];
    backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:backgroundImage.size.width * 0.5 topCapHeight:backgroundImage.size.height * 0.5];
    [[UISearchBar appearance] setSearchFieldBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [[UISearchBar appearance] setSearchTextPositionAdjustment:UIOffsetMake(8, 0)];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor colorWithRGB:0x0096ff]}];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName:ThemeColor} forState:UIControlStateNormal];
    
    //UITextField的光标颜色可以用这个控制
    [[UITextField appearance] setTintColor:ThemeColor];
    
}

@end
