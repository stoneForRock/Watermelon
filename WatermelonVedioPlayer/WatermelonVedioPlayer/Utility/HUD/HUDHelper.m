//
//  HUDHelper.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/7.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "HUDHelper.h"
#import <MBProgressHUD/MBProgressHUD.h>

static NSInteger const HUDDefaultShowTime = 1.0f;
static NSInteger const HUDLongShowTime = 1.8f;

// 分类型，暂时没用上
typedef NS_ENUM(NSInteger, HUDMaskType) {
    HUDMaskTypeNone = 1,
    HUDMaskTypeClear,
    HUDMaskTypeBlack,
    HUDMaskTypeGradient,
    HUDMaskTypeFullScreen
};

typedef NS_ENUM(NSInteger, HUDPosition) {
    HUDPositionCentre,
    HUDPositionTop,
    HUDPositionBottom
};

@implementation HUDHelper

+ (void)showHUDLoading:(UIView *)baseView {
    [self showHUDLoading:baseView];
}

+ (void)showHUDLoading:(UIView *)baseView text:(NSString *)text {
    [self showHUDLoading:baseView text:text enabledUserInteraction:YES];
}

+ (void)showHUDLoading:(UIView *)baseView text:(NSString *)text enabledUserInteraction:(BOOL)enabledUserInteraction {
    [self showHUDLoading:YES text:text image:nil duration:0 position:HUDPositionCentre baseView:baseView maskType:enabledUserInteraction ? HUDMaskTypeClear : HUDMaskTypeFullScreen];
}

// 提示性文字，默认显示再window上
+ (void)showHUDText:(NSString *)text duration:(NSTimeInterval)duration {
    [self showHUDLoading:NO text:text image:nil duration:duration position:HUDPositionCentre baseView:UIApplication.sharedApplication.keyWindow.rootViewController.view maskType:HUDMaskTypeFullScreen];
}
+ (void)showHUDText:(NSString *)text duration:(NSTimeInterval)duration inView:(UIView *)baseView {
    [self showHUDLoading:NO text:text image:nil duration:duration position:HUDPositionCentre baseView:baseView maskType:HUDMaskTypeFullScreen];
}

+ (void)showHUDWithSuccessText:(NSString *)text inView:(UIView *)baseView {
    [self showHUDLoading:NO text:text image:nil duration:0 position:HUDPositionCentre baseView:baseView maskType:HUDMaskTypeFullScreen];
}

+ (void)showHUDWithErrorText:(NSString *)text inView:(UIView *)baseView{
    [self showHUDLoading:NO text:text image:nil duration:0 position:HUDPositionBottom baseView:baseView maskType:HUDMaskTypeFullScreen];
}

+ (void)showHUDText:(NSString *)text
              image:(UIImage *)image
           duration:(NSTimeInterval)duration
           position:(HUDPosition)position
             inView:(UIView *)baseView {
    CGFloat mDuration = duration;
    if (mDuration <= 0) {
        mDuration = (text && text.length > 12) ? HUDLongShowTime : HUDDefaultShowTime;
    }
    
    [self showHUDLoading:NO text:text image:image duration:mDuration position:position baseView:baseView maskType:HUDMaskTypeFullScreen];
}

+ (void)showHUDLoading:(BOOL)loading
                  text:(NSString *)text
                 image:(UIImage *)image
              duration:(NSTimeInterval)duration
              position:(HUDPosition)position
              baseView:(UIView *)baseView
              maskType:(HUDMaskType)maskType
{
    if (loading == NO && (!text || text.length == 0)) {
        return;
    }
    
    if (loading && !baseView) {
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:baseView animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:13.0f];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    
    if (loading) {
        hud.mode = MBProgressHUDModeIndeterminate;
    } else {
        
        if(position == HUDPositionBottom){
            CGFloat half = ScreenFullHeight / 2 ;
            hud.offset = CGPointMake(0.f, half - 120 - SafeBottomHeight);
        }
        
        NSTimeInterval mDuration = duration > 0 ? duration: HUDDefaultShowTime;
        hud.bezelView.layer.cornerRadius = 5.0f;
        hud.mode = MBProgressHUDModeText;
        hud.margin = 8.0f;
        [hud hideAnimated:YES afterDelay:mDuration];
    }
}

+ (void)hideHUDView:(UIView *)baseView {
    UIView *mFatherView = baseView ?: [self getCurrentShowWindow];
    for (UIView *subVIew in mFatherView.subviews) {
        if ([subVIew isKindOfClass:[MBProgressHUD class]]) {
            [((MBProgressHUD *)subVIew) hideAnimated:YES];
            [subVIew removeFromSuperview];
        }
    }
    // 隐藏window上的MBProgressHUD
    for (UIView *subVIew in UIApplication.sharedApplication.keyWindow.rootViewController.view.subviews) {
        if ([subVIew isKindOfClass:[MBProgressHUD class]]) {
            [((MBProgressHUD *)subVIew) hideAnimated:YES];
            [subVIew removeFromSuperview];
        }
    }
}

+ (void)hideHUDView {
    [self hideHUDView:[self getCurrentShowWindow]];
}

#pragma mark -

+ (UIWindow *)getCurrentShowWindow {
    UIWindow *currentShowWindow = nil;
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            currentShowWindow = window;
            break;
        }
    }
    return currentShowWindow;
}

#pragma mark -
+ (void)showSystemLoadingInView:(UIView *)inView
{
    if (!inView) return;
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.frame = CGRectMake(0, 0, 20.0f, 20.0f);
    activityIndicatorView.center = CGPointMake(inView.bounds.size.width / 2, inView.bounds.size.height / 2);
    activityIndicatorView.tag = 21221;
    [activityIndicatorView startAnimating];
    
    [inView addSubview:activityIndicatorView];
    [inView bringSubviewToFront:activityIndicatorView];
}

+ (void)hideSystemLoadingInView:(UIView *)inView
{
    if (!inView) return;
    UIView *view = [inView viewWithTag:21221];
    if (view) {
        [view removeFromSuperview];
    }
}

+ (UIColor *)stringTOColor:(NSString *)colorStr{
    if (!colorStr || [colorStr isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[colorStr substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[colorStr substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[colorStr substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    
    return color;
}

@end
