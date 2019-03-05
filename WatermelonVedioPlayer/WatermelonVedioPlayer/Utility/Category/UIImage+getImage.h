//
//  UIImage+getImage.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (getImage)

+ (UIImage *)sc_imageWithColor:(UIColor *)color;

+ (UIImage *)sc_imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)sc_imageWithColor:(UIColor *)color coverColor:(UIColor *)color;

+ (UIImage *)sc_defaultHeaderImage;

@end
