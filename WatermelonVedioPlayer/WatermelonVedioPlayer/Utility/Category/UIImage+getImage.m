//
//  UIImage+getImage.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "UIImage+getImage.h"

@implementation UIImage (getImage)

+ (UIImage *)sc_imageWithColor:(UIColor *)color {
    return [self sc_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)sc_imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)sc_imageWithColor:(UIColor *)color coverColor:(UIColor *)coverColor
{
    UIImage *image1 = [UIImage sc_imageWithColor:color];
    UIImage *image2 = [UIImage sc_imageWithColor:coverColor];
    
    UIGraphicsBeginImageContext(image1.size);
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+ (UIImage *)sc_defaultHeaderImage {
    return [UIImage imageNamed:@"default_header"];
}

@end
