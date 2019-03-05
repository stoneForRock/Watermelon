//
//  UIImage+compress.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (compress)

/**
 通过二分法 压缩图片小于指定大小（不一定100%达到效果）
 
 @param image 需要压缩的图片
 @param maxLength 图片文件最大值
 @return 压缩后的文件
 */
+ (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;

/**
 图片格式
 
 @param image 需要获取格式的图片
 @return 返回图片格式
 */
+ (NSString *)imageFormat:(UIImage *)image;

@end
