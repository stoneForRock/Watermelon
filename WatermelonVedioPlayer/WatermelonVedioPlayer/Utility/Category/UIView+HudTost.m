//
//  UIView+HudTost.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "UIView+HudTost.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation UIView (HudTost)


- (void)sc_showHUD:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = text;
}

- (void)sc_hideHUD
{
    [MBProgressHUD hideHUDForView:self animated:YES];
}

- (void)sc_showToast:(NSString *)text
{
    [self sc_showToast:text afterDelay:kHudDefaultDuration];
}

- (void)sc_showToast:(NSString *)text afterDelay:(NSTimeInterval)delay
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor blackColor];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = kHudDefaultFont;
    hud.userInteractionEnabled = NO;    //can touch while show toast
    [hud hideAnimated:YES afterDelay:delay];
}

- (void)sc_showImageToast:(NSString *)text imageName:(NSString *)imageName {
    [self sc_showImageToast:text imageName:imageName afterDelay:kHudDefaultDuration];
}

- (void)sc_showImageToast:(NSString *)text imageName:(NSString *)imageName afterDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    hud.bezelView.color = [UIColor blackColor];
    hud.label.text = text;
    hud.label.font = kHudDefaultFont;
    hud.label.textColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:delay];
}

@end
