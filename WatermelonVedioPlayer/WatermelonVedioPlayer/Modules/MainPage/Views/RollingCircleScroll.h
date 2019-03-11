//
//  RollingCircleScroll.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/8.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RollingCircleScrollDelegate <NSObject>
@optional

- (void)rollingCircleScrollClickPageModel:(id)pageModel;

@end

NS_ASSUME_NONNULL_BEGIN

/**
 滚动循环scroll
 */
@interface RollingCircleScroll : UIView

@property (nonatomic, assign) NSInteger scrollInterval;
@property (nonatomic, assign) id<RollingCircleScrollDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withDataSources:(NSArray *)dataSources;

@end

NS_ASSUME_NONNULL_END
