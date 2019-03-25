//
//  FilterSortView.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/20.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "FilterSortView.h"
#import "UIImage+getImage.h"
#import "NSString+Tool.h"

@interface FilterSortView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *sortArray;//排序数组
@property (nonatomic, strong) NSArray *filterArray;//过滤数组

@property (nonatomic, strong) UIScrollView *sortScrollView;
@property (nonatomic, strong) UIScrollView *filterScrollView;

@end

@implementation FilterSortView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithFilterType:(FilterSortType)type frame:(CGRect)frame delegate:(id<FilterSortViewDelegate>)delegate dataSource:(id<FilterSortViewDataSource>)dataSource {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.filterSortViewDelgate = delegate;
        self.filterSortViewDataSource = dataSource;
        
        self.sortScrollView = [[UIScrollView alloc] init];
        self.sortScrollView.delegate = self;
        [self addSubview:self.sortScrollView];
        
        self.filterScrollView = [[UIScrollView alloc] init];
        self.filterScrollView.delegate = self;
        [self addSubview:self.filterScrollView];
        
        self.sortArray = [NSArray array];
        if (self.filterSortViewDataSource != nil && [self.filterSortViewDataSource respondsToSelector:@selector(sortDataSource)]) {
            self.sortArray = [self.filterSortViewDataSource sortDataSource];
        }
        
        self.filterArray = [NSArray array];
        if (self.filterSortViewDataSource != nil && [self.filterSortViewDataSource respondsToSelector:@selector(filterDataSource)]) {
            self.filterArray = [self.filterSortViewDataSource filterDataSource];
        }
        CGFloat btnHeight = 0.0;
        if (type == FilterSort) {
            btnHeight = frame.size.height/2 - 10;
        } else {
            btnHeight = frame.size.height - 10;
        }
        CGFloat sortContentWidth = 0.0;
        for (int i = 0; i < self.sortArray.count; i ++) {
            UIButton *sortBtn = [UIButton buttonWithFilterSortTypeWithTitle:@"排序" btnHeight:btnHeight];
            [sortBtn addTarget:self action:@selector(sortAction:) forControlEvents:UIControlEventTouchUpInside];
            sortBtn.center = CGPointMake(sortBtn.bounds.size.width/2 + sortContentWidth + 10, 5 + btnHeight/2);
            [self.sortScrollView addSubview:sortBtn];
            sortContentWidth += sortBtn.bounds.size.width + 10;
        }
        self.sortScrollView.frame = CGRectMake(0, 0, frame.size.width, btnHeight + 10);
        [self.sortScrollView setContentSize:CGSizeMake(sortContentWidth + 10, btnHeight + 10)];
        
        CGFloat filterContentWidth = 0.0;
        for (int i = 0; i < self.filterArray.count; i ++) {
            UIButton *filterBtn = [UIButton buttonWithFilterSortTypeWithTitle:@"筛选" btnHeight:btnHeight];
            [filterBtn addTarget:self action:@selector(filterAction:) forControlEvents:UIControlEventTouchUpInside];
            filterBtn.center = CGPointMake(filterBtn.bounds.size.width/2 + filterContentWidth + 10, 5 + btnHeight/2);
            [self.filterScrollView addSubview:filterBtn];
            filterContentWidth += filterBtn.bounds.size.width + 10;
        }
        self.filterScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.sortScrollView.frame), frame.size.width, btnHeight + 10);
        [self.filterScrollView setContentSize:CGSizeMake(filterContentWidth + 10, btnHeight + 10)];
    }
    return self;
}

- (void)sortAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)filterAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end

@implementation UIButton (filterSort)

+ (instancetype)buttonWithFilterSortTypeWithTitle:(NSString *)title btnHeight:(CGFloat)btnHeight {
    UIButton *filterSortBtn = [self buttonWithType:UIButtonTypeCustom];
    [filterSortBtn setTitle:title forState:UIControlStateNormal];
    [filterSortBtn setTitleColor:COLORWITHRGBADIVIDE255(55, 55, 55, 1) forState:UIControlStateNormal];
    [filterSortBtn setBackgroundImage:[UIImage sc_imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [filterSortBtn setTitleColor:COLORWITHRGBADIVIDE255(194, 154, 104, 1) forState:UIControlStateSelected];
    [filterSortBtn setBackgroundImage:[UIImage sc_imageWithColor:COLORWITHRGBADIVIDE255(241, 242, 227, 1)] forState:UIControlStateSelected];
    filterSortBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    filterSortBtn.layer.cornerRadius = btnHeight/2;
    filterSortBtn.layer.masksToBounds = YES;
    
    CGSize titleSize = [title sc_sizeWithFont:[UIFont systemFontOfSize:14]];
    filterSortBtn.bounds = CGRectMake(0, 0, titleSize.width + 30, btnHeight);
    
    return filterSortBtn;
}

@end
