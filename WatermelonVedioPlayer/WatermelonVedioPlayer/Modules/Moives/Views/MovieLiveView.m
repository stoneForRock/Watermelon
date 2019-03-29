//
//  MovieLiveView.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/29.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MovieLiveView.h"
#import "QCPlayerView.h"

@interface MovieLiveView ()<QCPlayerDelegate>

@property (nonatomic, strong) UIImageView *videoADImgView;//广告视图
@property (nonatomic, strong) UILabel *adDowncountLabel;//广告倒计时label

@property (nonatomic, strong) NSTimer *downCountTimer;

@end

@implementation MovieLiveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.videoADImgView];
        [self.videoADImgView addSubview:self.adDowncountLabel];
        
        self.videoADImgView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.adDowncountLabel.frame = CGRectMake(frame.size.width - 40, 20, 24, 24);
        
    }
    return self;
}

- (void)setAdInfo:(NSDictionary *)adInfo {
    _adInfo = adInfo;
    
}

#pragma mark - lazyLoad

- (UIImageView *)videoADImgView {
    if (!_videoADImgView) {
        _videoADImgView = [[UIImageView alloc] init];
        _videoADImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _videoADImgView;
}

- (UILabel *)adDowncountLabel {
    if (!_adDowncountLabel) {
        _adDowncountLabel = [[UILabel alloc] init];
        _adDowncountLabel.backgroundColor = COLORWITHRGBADIVIDE255(51, 51, 51, 1);
        _adDowncountLabel.textColor = [UIColor whiteColor];
        _adDowncountLabel.font = [UIFont systemFontOfSize:12];
        _adDowncountLabel.layer.cornerRadius = 12;
        _adDowncountLabel.layer.masksToBounds = YES;
    }
    return _adDowncountLabel;
}

@end
