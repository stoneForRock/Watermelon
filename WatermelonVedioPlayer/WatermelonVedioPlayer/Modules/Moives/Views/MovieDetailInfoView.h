//
//  MovieDetailInfoView.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/2.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoivesModel.h"

@protocol MovieDetailInfoViewDelegate <NSObject>
@optional

- (void)showIntroduceMovie:(MoivesModel *)movie;
- (void)dwonLoadMovie:(MoivesModel *)movie;
- (void)shareMovie:(MoivesModel *)movie;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MovieDetailInfoView : UIView

@property (nonatomic, strong) MoivesModel *infoModel;
@property (nonatomic, strong) NSDictionary *adInfo;//广告

@property (nonatomic, assign) id<MovieDetailInfoViewDelegate> infoViewDelegate;

- (void)failLoadAdInfo;

@end

NS_ASSUME_NONNULL_END
