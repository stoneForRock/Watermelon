//
//  UIView+Frame.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (CGPoint) sc_origin
{
    return self.frame.origin;
}

- (void) setSc_origin:(CGPoint)aPoint {
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

- (CGSize) sc_size
{
    return self.frame.size;
}

- (void) setSc_size: (CGSize) aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

- (CGFloat)sc_height
{
    return self.frame.size.height;
}

- (void)setSc_height: (CGFloat) newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat)sc_width
{
    return self.frame.size.width;
}

- (void)setSc_width: (CGFloat) newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat)sc_top
{
    return self.frame.origin.y;
}

- (void)setSc_top: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)sc_left
{
    return self.frame.origin.x;
}

- (void)setSc_left:(CGFloat)sc_left
{
    CGRect newframe = self.frame;
    newframe.origin.x = sc_left;
    self.frame = newframe;
}

- (CGFloat) sc_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setSc_bottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) sc_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setSc_right: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (void)setSc_x:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)sc_x
{
    return self.frame.origin.x;
}

- (void)setSc_y:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)sc_y
{
    return self.frame.origin.y;
}

- (CGFloat)sc_max_X{
    return CGRectGetMaxX(self.frame);
}
- (void)setSc_max_X:(CGFloat)max_X{}


- (CGFloat)sc_max_Y{
    return CGRectGetMaxY(self.frame);
}
- (void)setSc_max_Y:(CGFloat)max_Y{}


- (void)setSc_centerX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)sc_centerX
{
    return self.center.x;
}

- (void)setSc_centerY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)sc_centerY
{
    return self.center.y;
}

- (UIView *)sc_addLineAtRect:(CGRect)rect {
    UIView *line = [[UIView alloc] initWithFrame:rect];
    line.backgroundColor = ThemeLineColor;
    [self addSubview:line];
    return line;
}

- (void)setRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)setDefaultShadow {
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowColor = ThemeLineColor.CGColor;
    self.layer.shadowOpacity = 1;
}

- (UITableView *)getSuperTableView {
    if (self.superview) {
        if ([self.superview isKindOfClass:[UITableView class]]) {
            return (UITableView *)self.superview;
        } else {
            return [self.superview getSuperTableView];
        }
    } else {
        return nil;
    }
}

@end
