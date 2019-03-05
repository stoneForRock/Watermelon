//
//  UIView+HudTost.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kHudDefaultDuration 1.2
#define kHudDefaultFont [UIFont systemFontOfSize:14]

@interface UIView (HudTost)

- (void)sc_showHUD:(NSString *)text;
- (void)sc_hideHUD;

- (void)sc_showToast:(NSString *)text;
- (void)sc_showToast:(NSString *)text afterDelay:(NSTimeInterval)delay;

- (void)sc_showImageToast:(NSString *)text imageName:(NSString *)imageName;
- (void)sc_showImageToast:(NSString *)text imageName:(NSString *)imageName afterDelay:(NSTimeInterval)delay;

@end
