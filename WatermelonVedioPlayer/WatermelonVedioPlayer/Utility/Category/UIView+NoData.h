//
//  UIView+NoData.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/27.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (NoData)

- (void)showNoDataView:(NSString *)text;

- (void)showNoDataView:(NSString *)text offsetY:(CGFloat)y;

- (void)hideNoDataView;

@end

NS_ASSUME_NONNULL_END
