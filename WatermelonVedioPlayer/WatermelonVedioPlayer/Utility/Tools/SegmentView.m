//
//  SegmentView.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "SegmentView.h"
#import "UIView+Frame.h"

#define kSegmentWidth ScreenFullWidth
#define kSegmentHeight 44

#define kIndicatorLength 30

#define kTintColor ThemeColor

@implementation SegmentView
{
    UIView *_indicator;
    NSMutableArray *_segmentButtons;
    CGFloat segmentWidth;
    CGFloat segmentHeight;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        segmentWidth = frame.size.width;
        segmentHeight = frame.size.height;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    segmentWidth = kSegmentWidth;
    segmentHeight = kSegmentHeight;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setHasShadow:(BOOL)hasShadow {
    _hasShadow = hasShadow;
    if (hasShadow) {
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowColor = ThemeLineColor.CGColor;
        self.layer.shadowOpacity = .3;
    }
}

- (void)setSegmentTitles:(NSArray<NSString *> *)titles
{
    self.titles = titles;
    
    if (_segmentButtons.count > 0) {
        [_segmentButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    _segmentButtons = [NSMutableArray arrayWithCapacity:titles.count];
    CGFloat varLength = segmentWidth/titles.count;
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:COLORWITHRGBADIVIDE255(194, 154, 104, 1) forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        button.frame = CGRectMake(varLength*idx, 0, varLength, self->segmentHeight);
        button.tag = idx;
        [button addTarget:self action:@selector(segmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self->_segmentButtons addObject:button];
        button.selected = idx==0;
    }];
    
    if (!_indicator) {
        _indicator = [[UIView alloc] initWithFrame:CGRectMake((varLength-kIndicatorLength)/2, segmentHeight - 2, kIndicatorLength, 2)];
        _indicator.backgroundColor = COLORWITHRGBADIVIDE255(194, 154, 104, 1);
        [self addSubview:_indicator];
    }
}

- (IBAction)segmentButtonAction:(UIButton *)sender {
    [self setSegmentSelectedIndex:sender.tag animated:YES];
}

- (void)setSegmentSelectedIndex:(NSUInteger)index animated:(BOOL)animated
{
    [self setSegmentSelectedIndexNoDelegate:index animated:animated];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(segmentView:didSelectIndex:)]) {
        [self.delegate segmentView:self didSelectIndex:self.selectedIndex];
    }
}

- (void)setSegmentSelectedIndexNoDelegate:(NSUInteger)index animated:(BOOL)animated{
    if (self.selectedIndex == index) {
        return;
    }
    
    [_segmentButtons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == index) {
            obj.selected = YES;
        } else {
            obj.selected = NO;
        }
    }];
    
    CGFloat varLength = segmentWidth/_segmentButtons.count;
    [UIView animateWithDuration:animated?.2:0 animations:^{
        //        _indicator.frame = CGRectMake(index*varLength, 42, varLength, 2);
        self->_indicator.sc_left = index*varLength+(varLength-kIndicatorLength)/2;
    }];
    
    self.selectedIndex = index;
}

@end
