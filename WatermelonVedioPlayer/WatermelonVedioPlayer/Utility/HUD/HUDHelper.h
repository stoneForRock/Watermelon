//
//  HUDHelper.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/7.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HUDHelper : NSObject
// 菊花加文字，可以enabledUserInteraction是否锁定当前View的操作
+ (void)showHUDLoading:(UIView *)baseView;
+ (void)showHUDLoading:(UIView *)baseView text:(NSString *)text;

// 提示性文字，默认显示再window上
+ (void)showHUDText:(NSString *)text duration:(NSTimeInterval)duration;
+ (void)showHUDText:(NSString *)text duration:(NSTimeInterval)duration inView:(UIView *)baseView;
+ (void)showHUDWithSuccessText:(NSString *)text inView:(UIView *)baseView;
+ (void)showHUDWithErrorText:(NSString *)text inView:(UIView *)baseView;

// 隐藏
+ (void)hideHUDView:(UIView *)baseView;   // 针对菊花
+ (void)hideHUDView; // 针对提示性文字

// 显示系统菊花，居中现实
+ (void)showSystemLoadingInView:(UIView *)inView;
+ (void)hideSystemLoadingInView:(UIView *)inView;

@end

NS_ASSUME_NONNULL_END
