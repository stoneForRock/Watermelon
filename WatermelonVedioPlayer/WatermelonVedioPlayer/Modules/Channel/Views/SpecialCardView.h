//
//  SpecialCardView.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/19.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SpecialCardViewDelegate <NSObject>
@optional

- (void)clickSpecialCard:(NSDictionary *)columnInfo;

@end

NS_ASSUME_NONNULL_BEGIN

@interface SpecialCardView : UIView

@property (nonatomic, strong) NSDictionary *columnSubObj;
@property (nonatomic, assign) id<SpecialCardViewDelegate> specialCardViewDelegate;

@end

NS_ASSUME_NONNULL_END
