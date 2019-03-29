//
//  MovieLiveView.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/29.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoivesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieLiveView : UIView

@property (nonatomic, strong) MoivesModel *movieModel;
@property (nonatomic, strong) NSDictionary *adInfo;//广告

@end

NS_ASSUME_NONNULL_END
