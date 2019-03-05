//
//  UIView+Frame.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property CGPoint sc_origin;
@property CGSize  sc_size;
@property CGFloat sc_height;
@property CGFloat sc_width;
@property CGFloat sc_top;
@property CGFloat sc_left;
@property CGFloat sc_bottom;
@property CGFloat sc_right;

@property CGFloat sc_x;
@property CGFloat sc_y;
@property CGFloat sc_max_X;
@property CGFloat sc_max_Y;
@property CGFloat sc_centerX;
@property CGFloat sc_centerY;
/**
 添加分割线
 */
- (UIView *)sc_addLineAtRect:(CGRect)rect;

/**
 圆角
 */
- (void)setRadius:(CGFloat)radius;

/**
 阴影
 */
- (void)setDefaultShadow;


/**
 获取cell的tableView
 */
- (UITableView *)getSuperTableView;

/**
 缺失页提示
 */
- (void)sc_showNoDataView:(NSString *)text;
- (void)sc_hideNoDataView;

@end
