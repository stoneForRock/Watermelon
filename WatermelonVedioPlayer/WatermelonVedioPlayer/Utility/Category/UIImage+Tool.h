//
//  UIImage+Tool.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tool)
// 压缩图片大小：改变其分辨率
- (UIImage *)resizedImageWithWidth:(CGFloat)width
                            height:(CGFloat)height
                            opaque:(BOOL)bOpaque
                             scale:(CGFloat)fScale;
- (UIImage *)resizedImageWithSize:(CGSize)size;
- (UIImage *)stretchedImageWithLeftCapRatio:(float)fLeft topCapRatio:(float)rTop;

- (UIImage *)sc_cropEqualScaleImageToSize:(CGSize)size;

@end
