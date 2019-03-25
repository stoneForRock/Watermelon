//
//  FilterSortView.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/20.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FilterSortType) {
    FilterSort = 0,//排序和过滤
    OnlyFilter,//只有过滤，没有排序
};

@protocol FilterSortViewDelegate <NSObject>
@optional

- (void)filterSortDidChangeWithSortData:(NSDictionary *)sortData filterData:(NSDictionary *)filterData;

@end

@protocol FilterSortViewDataSource <NSObject>
- (NSArray<NSDictionary *> *)filterDataSource;
@optional
- (NSArray<NSDictionary *> *)sortDataSource;
@end

NS_ASSUME_NONNULL_BEGIN

@interface FilterSortView : UIView

- (instancetype)initWithFilterType:(FilterSortType)type frame:(CGRect)frame delegate:(id<FilterSortViewDelegate>)delegate dataSource:(id<FilterSortViewDataSource>)dataSource;

@property (nonatomic, assign) id<FilterSortViewDelegate> filterSortViewDelgate;
@property (nonatomic, assign) id<FilterSortViewDataSource> filterSortViewDataSource;

@end

@interface UIButton (filterSort)

+ (instancetype)buttonWithFilterSortTypeWithTitle:(NSString *)title btnHeight:(CGFloat)btnHeight;

@end

NS_ASSUME_NONNULL_END
