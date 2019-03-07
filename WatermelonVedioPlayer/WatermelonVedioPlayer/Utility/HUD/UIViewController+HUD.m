//
//  UIViewController+HUD.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/7.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "HUDHelper.h"

@implementation UIViewController (HUD)

//默认系统的
- (void)showDCHUDLoading {
    [HUDHelper showHUDLoading:self.view text:nil];
}

- (void)showDCHUDLoadingOnWindow {
    [HUDHelper showHUDLoading:UIApplication.sharedApplication.keyWindow.rootViewController.view text:nil];
}

- (void)showHUDLoadingText:(NSString *)text {
    [HUDHelper showHUDLoading:self.view text:text];
}

- (void)showPCHUDLoadingOnWindowText:(NSString *)text {
    [HUDHelper showHUDLoading:UIApplication.sharedApplication.keyWindow.rootViewController.view text:text];
}

- (void)showHUDText:(NSString *)text {
    if(text == nil || [text isEqualToString:@""]) return;
    [HUDHelper showHUDText:text duration:0 inView:self.view];
}

- (void)showHUDText:(NSString *)text duration:(NSTimeInterval)duration {
    [HUDHelper showHUDText:text duration:duration inView:self.view];
}

- (void)showHUDWithSuccessText:(NSString *)text {
    [HUDHelper showHUDWithSuccessText:text inView:self.view];
}

- (void)showHUDWithErrorText:(NSString *)text {
    [HUDHelper showHUDWithErrorText:text inView:self.view];
}

- (void)hideHUDView {
    [HUDHelper hideHUDView:self.view];
}

@end
