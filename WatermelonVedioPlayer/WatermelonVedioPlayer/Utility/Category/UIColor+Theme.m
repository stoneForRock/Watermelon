//
//  UIColor+Theme.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "UIColor+Theme.h"

@implementation UIColor (Theme)

+ (UIColor *)themeTintColor {
    return COLORWITHRGBADIVIDE255(194, 154, 104, 1);
}

+ (UIColor *)themeTextColor {
    return [self colorWithRGB:0xB4B4B4];
}

+ (UIColor *)navTitleColor {
    return [self colorWithRGB:0x2d2d2d];
}

+ (UIColor *)themeBackgroundColor {
    return [self colorWithRGB:0xFFFFFF];
}

+ (UIColor *)vcBackgroundColor {
    return [self colorWithRGB:0xF2F2F2];
}

+ (UIColor *)navBackgroundColor {
    return [self colorWithRGB:0xFFFFFF];
}

+ (UIColor *)placeholderColor {
    return [self colorWithRGB:0xb2b2b2];
}

+ (UIColor *)btnColor {
    return [self colorWithRGB:0x0096ff];
}

+ (UIColor *)textColor333333 {
    return [self colorWithRGB:0x333333];
}

+ (UIColor *)textColor666666 {
    return [self colorWithRGB:0x666666];
}

+ (UIColor *)textColor999999 {
    return [self colorWithRGB:0x999999];
}

+ (UIColor *)lineColor {
    return [self colorWithRGB:0xcecece];
}

+ (UIColor *)subtitleColor {
    return [self colorWithRGB:0xFFFFFF];
}

+ (UIColor *)colorWithRGB:(int)rgbValue {
    return [UIColor colorWithRGB:rgbValue
                           alpha:1];
}

+ (UIColor *)colorWithRGB:(int)rgbValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float) (((rgbValue) & 0xFF0000) >> 16)) / 255.0
                           green:((float) (((rgbValue) & 0x00FF00) >> 8)) / 255.0
                            blue:((float) ((rgbValue) & 0x0000FF)) / 255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHexRGB:(NSString *)inColorString {
    UIColor *result = nil;
    
    unsigned int colorCode = 0;
    
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
        
    {
        
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        
        (void) [scanner scanHexInt:&colorCode]; // ignore error
        
    }
    
    redByte = (unsigned char) (colorCode >> 16);
    
    greenByte = (unsigned char) (colorCode >> 8);
    
    blueByte = (unsigned char) (colorCode); // masks off high bits
    
    result = [UIColor
              
              colorWithRed: (float)redByte / 0xff
              
              green: (float)greenByte/ 0xff
              
              blue: (float)blueByte / 0xff
              
              alpha:1.0];
    
    return result;
}

+ (UIColor *)colorWithHexRGB:(NSString *)inColorString alpha:(CGFloat)alpha {
    UIColor *result = nil;
    
    unsigned int colorCode = 0;
    
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
        
    {
        
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        
        (void) [scanner scanHexInt:&colorCode]; // ignore error
        
    }
    
    redByte = (unsigned char) (colorCode >> 16);
    
    greenByte = (unsigned char) (colorCode >> 8);
    
    blueByte = (unsigned char) (colorCode); // masks off high bits
    
    result = [UIColor
              
              colorWithRed: (float)redByte / 0xff
              
              green: (float)greenByte/ 0xff
              
              blue: (float)blueByte / 0xff
              
              alpha:alpha];
    
    return result;
}


@end
