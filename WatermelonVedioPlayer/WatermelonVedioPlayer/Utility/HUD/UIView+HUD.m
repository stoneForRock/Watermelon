//
//  UIView+HUD.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/7.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "UIView+HUD.h"
#import "HUDHelper.h"

@implementation UIView (HUD)

// 默认的黑色
- (void)showHUDLoading {
    [HUDHelper showHUDLoading:self text:nil];
}

// 默认的黑色
- (void)showHUDLoadingText:(NSString *)text {
    [HUDHelper showHUDLoading:self text:text];
}

- (void)showHUDText:(NSString *)text {
    if(text == nil || [text isEqualToString:@""]) return;
    [HUDHelper showHUDText:text duration:0 inView:self];
}

- (void)showHUDText:(NSString *)text duration:(NSTimeInterval)duration {
    [HUDHelper showHUDText:text duration:duration inView:self];
}

- (void)showHUDWithSuccessText:(NSString *)text {
    [HUDHelper showHUDWithSuccessText:text inView:self];
}

- (void)showHUDWithErrorText:(NSString *)text {
    [HUDHelper showHUDWithErrorText:text inView:self];
}

- (void)hideHUDView {
    [HUDHelper hideHUDView:self];
}

@end
