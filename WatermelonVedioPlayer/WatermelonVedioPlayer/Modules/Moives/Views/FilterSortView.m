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

@interface FilterSortView ()

@property (nonatomic, strong) NSArray *sortArray;//排序数组
@property (nonatomic, strong) NSArray *filterArray;//过滤数组

@end

@implementation FilterSortView

- (instancetype)initWithFilterType:(FilterSortType)type frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

@end

@implementation UIButton (filterSort)

+ (instancetype)buttonWithFilterSortTypeWithTitle:(NSString *)title btnHeight:(CGFloat)btnHeight {
    UIButton *filterSortBtn = [self buttonWithType:UIButtonTypeCustom];
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
