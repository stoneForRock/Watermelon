//
//  UIView+HUD.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/7.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIView (HUD)

// 默认的黑色
- (void)showHUDLoading;
// 默认的黑色
- (void)showHUDLoadingText:(NSString *)text;

- (void)showHUDText:(NSString *)text;
- (void)showHUDText:(NSString *)text duration:(NSTimeInterval)duration;
- (void)showHUDWithSuccessText:(NSString *)text;
- (void)showHUDWithErrorText:(NSString *)text;
- (void)hideHUDView;

@end

NS_ASSUME_NONNULL_END
