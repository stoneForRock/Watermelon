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

@end

NS_ASSUME_NONNULL_END
