//
//  MovieDetailInfoView.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/2.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoivesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieDetailInfoView : UIView

@property (nonatomic, strong) MoivesModel *infoModel;
@property (nonatomic, strong) NSDictionary *adInfo;//广告

- (void)failLoadAdInfo;

@end

NS_ASSUME_NONNULL_END
