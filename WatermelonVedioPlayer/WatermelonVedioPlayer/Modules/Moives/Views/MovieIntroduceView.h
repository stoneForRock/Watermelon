//
//  MovieIntroduceView.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/4.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoivesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieIntroduceView : UIView
@property (nonatomic, strong) MoivesModel *movie;

+ (MovieIntroduceView *)showIntroduceViewWithMovie:(MoivesModel *)movie rect:(CGRect)showRect inView:(UIView *)supView;

@end

NS_ASSUME_NONNULL_END
