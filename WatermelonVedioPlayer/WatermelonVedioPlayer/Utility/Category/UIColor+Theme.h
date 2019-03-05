//
//  UIColor+Theme.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRGB:rgbValue]
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRGB:rgbValue alpha:alphaValue]

@interface UIColor (Theme)

+ (UIColor *)themeTintColor;
+ (UIColor *)themeTextColor;
+ (UIColor *)navTitleColor;
+ (UIColor *)themeBackgroundColor;
+ (UIColor *)vcBackgroundColor;
+ (UIColor *)navBackgroundColor;
+ (UIColor *)placeholderColor;
+ (UIColor *)btnColor;

+ (UIColor *)textColor333333;/**< 333333 字体灰色 */
+ (UIColor *)textColor666666;/**< 666666 字体淡灰色 */
+ (UIColor *)textColor999999;/**< 999999 字体淡灰色 */

+ (UIColor *)lineColor;
+ (UIColor *)subtitleColor;

+ (UIColor *)colorWithRGB:(int)rgbValue;
+ (UIColor *)colorWithRGB:(int)rgbValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexRGB:(NSString *)inColorString;
+ (UIColor *)colorWithHexRGB:(NSString *)inColorString alpha:(CGFloat)alpha;

@end
