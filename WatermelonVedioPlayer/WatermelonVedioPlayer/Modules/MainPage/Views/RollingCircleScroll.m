//
//  RollingCircleScroll.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/8.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "RollingCircleScroll.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RollingCircleScroll () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *scrollList;//数据源
@property (nonatomic, assign) NSInteger currentPage;//当前页
 
@property (nonatomic, strong) NSTimer *scrollTimer;

@end

@implementation RollingCircleScroll

- (instancetype)initWithFrame:(CGRect)frame withDataSources:(NSArray *)dataSources {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = frame.size.width - 60;
        
        [self addSubview:self.scrollView];
        self.scrollView.frame = CGRectMake(30, 0, width + 10, frame.size.height - 20);
        
        [self addSubview:self.pageControl];
        self.pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.scrollView.frame) , frame.size.width, 20);
        self.pageControl.numberOfPages = dataSources.count;
        
        if (dataSources.count > 0) {
            self.scrollList = [NSMutableArray arrayWithArray:dataSources];
            [self.scrollList insertObject:[dataSources lastObject] atIndex:0];
            if (dataSources.count > 1) {
                [self.scrollList addObject:[dataSources objectAtIndex:0]];
            }
        }
        
        for (int i = 0; i < self.scrollList.count; i ++) {
            NSDictionary *adInfo = self.scrollList[i];
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.frame = CGRectMake((width + 10) * i, 10, width, frame.size.height - 40);
            [imageView sd_setImageWithURL:[NSURL URLWithString:adInfo[@"thumbnail"]] placeholderImage:[UIImage imageNamed:@"LaunchImage"]];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 6.0;
            imageView.userInteractionEnabled = YES;
            imageView.tag = 188 + i;
            [self.scrollView addSubview:imageView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAd:)];
            [imageView addGestureRecognizer:tapGesture];
        }
        
        self.scrollView.contentSize = CGSizeMake(self.scrollList.count * frame.size.width, frame.size.height - 20);
        self.scrollView.contentOffset = CGPointMake(width + 10, 0);
        
        [self startAutoScroll];
    }
    return self;
}

- (void)makeFinishScrolling {
    CGFloat width = self.scrollView.frame.size.width;
    NSInteger currentPage = (self.scrollView.contentOffset.x + width/2.0)/width;

    if (currentPage == self.scrollList.count-1) {
        [self.scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
        self.pageControl.currentPage = 0;
    } else if (currentPage == 0) {
        self.pageControl.currentPage = self.scrollList.count - 2;

        [self.scrollView setContentOffset:CGPointMake(width * (self.scrollList.count-2), 0) animated:NO];
    } else {
        self.pageControl.currentPage = currentPage-1 ;
    }
}

- (void)startAutoScroll {
    if (self.scrollTimer) {
        return;
    }
    
    self.scrollTimer = [NSTimer timerWithTimeInterval:self.scrollInterval == 0?3:self.scrollInterval target:self selector:@selector(doScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.scrollTimer forMode:NSRunLoopCommonModes];
}

- (void)doScroll {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + self.scrollView.frame.size.width, 0) animated:YES];
}

- (void)stopAutoScroll {
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
}

- (void)tapAd:(UIGestureRecognizer *)recognizer {
    UIView *tapView = recognizer.view;
    NSDictionary *tapAdInfo = self.scrollList[tapView.tag - 188];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(rollingCircleScrollClickPage:)]) {
        [self.delegate rollingCircleScrollClickPage:tapAdInfo];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self makeFinishScrolling];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self makeFinishScrolling];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopAutoScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startAutoScroll];
}

#pragma mark - lazyLoad

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.clipsToBounds = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = COLORWITHRGBADIVIDE255(109, 109, 109, 1.0);
        _pageControl.currentPageIndicatorTintColor = COLORWITHRGBADIVIDE255(249, 220, 165, 1.0);
    }
    return _pageControl;
}

@end
