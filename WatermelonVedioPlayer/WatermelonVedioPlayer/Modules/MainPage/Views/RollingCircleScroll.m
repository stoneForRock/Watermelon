//
//  RollingCircleScroll.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/8.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "RollingCircleScroll.h"
//https://www.jianshu.com/p/cc2eb8e058e5
@interface RollingCircleScroll () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *scrollList;//数据源
@property (nonatomic, assign) NSInteger currentPage;//当前页

@end

@implementation RollingCircleScroll

- (instancetype)initWithFrame:(CGRect)frame withDataSources:(NSArray *)dataSources {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.scrollView];
        self.scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    }
    return self;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

@end
