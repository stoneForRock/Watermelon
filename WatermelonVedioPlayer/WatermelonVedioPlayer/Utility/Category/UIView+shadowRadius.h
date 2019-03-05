//
//  UIView+shadowRadius.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (shadowRadius)
/**
 View周边加阴影，并且同时圆角
 
 @param view 需要加圆角阴影的View
 @param shadowOpacity 透明度
 @param shadowRadius 阴影的宽度
 @param cornerRadius 圆角弧度
 @param viewWidth View的总宽度（有些情况下获取到的View的尺寸不准确）
 */
+ (void)clAddShadowToView:(UIView *)view
              withOpacity:(float)shadowOpacity
             shadowRadius:(CGFloat)shadowRadius
          andCornerRadius:(CGFloat)cornerRadius width:(float)viewWidth;
@end
