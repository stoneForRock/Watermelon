//
//  MovieCover1View.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/14.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoivesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieCoverView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) MoivesModel *movieModel;

@end

NS_ASSUME_NONNULL_END
