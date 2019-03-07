//
//  UIViewController+HUD.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/7.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HUD)

- (void)showDCHUDLoading;//默认系统的
- (void)showDCHUDLoadingOnWindow;//默认系统的

- (void)showHUDLoadingText:(NSString *)text;//默认系统的 带text

// 提示性文字，默认显示再window上
- (void)showHUDText:(NSString *)text;
- (void)showHUDText:(NSString *)text duration:(NSTimeInterval)duration;

- (void)showHUDWithSuccessText:(NSString *)text;
- (void)showHUDWithErrorText:(NSString *)text;

// 隐藏
- (void)hideHUDView; // 针对提示性文字

@end

NS_ASSUME_NONNULL_END
