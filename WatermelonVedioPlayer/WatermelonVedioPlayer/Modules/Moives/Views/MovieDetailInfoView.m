//
//  MovieDetailInfoView.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/2.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MovieDetailInfoView.h"

@interface MovieDetailInfoView ()

@property (nonatomic, strong) UIImageView *adImgView;//广告图
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *introduceLabel;

@end

@implementation MovieDetailInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setInfoModel:(MoivesModel *)infoModel {
    _infoModel = infoModel;
    
}

- (void)setAdInfo:(NSDictionary *)adInfo {
    _adInfo = adInfo;
    
}

@end
