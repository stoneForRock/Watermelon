//
//  MovieDetailInfoView.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/2.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MovieDetailInfoView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MovieDetailInfoView ()

@property (nonatomic, strong) UIImageView *adImgView;//广告图
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;//时间和播放次数label

@property (nonatomic, strong) UIButton *praiseBtn;
@property (nonatomic, strong) UIButton *unpraiseBtn;
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UIView *progressBGView;
@property (nonatomic, strong) UILabel *progressLabel;

@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIView *introduceView;
@property (nonatomic, strong) UIButton *introduceBtn;

@end

@implementation MovieDetailInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.adImgView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.praiseBtn];
        [self addSubview:self.unpraiseBtn];
        [self addSubview:self.progressBGView];
        [self addSubview:self.progressLabel];
        [self addSubview:self.introduceView];
        
        [self.progressBGView addSubview:self.progressView];
        [self.introduceView addSubview:self.introduceLabel];
        [self.introduceView addSubview:self.introduceBtn];
        
        self.adImgView.frame = CGRectMake(15, 10, frame.size.width - 30, 80);
        self.nameLabel.frame = CGRectMake(15, CGRectGetMaxY(self.adImgView.frame) + 10, frame.size.width - 120, 40);
        self.timeLabel.frame = CGRectMake(15, CGRectGetMaxY(self.nameLabel.frame), frame.size.width - 30, 30);
    }
    return self;
}

- (void)setInfoModel:(MoivesModel *)infoModel {
    _infoModel = infoModel;
    self.nameLabel.text = infoModel.movName;
    self.timeLabel.text = [NSString stringWithFormat:@"%@ * %.2f万次播放",infoModel.createTime,[infoModel.playCount doubleValue]/10000];
}

- (void)setAdInfo:(NSDictionary *)adInfo {
    _adInfo = adInfo;
    [self.adImgView sd_setImageWithURL:[NSURL URLWithString:adInfo[@"thumbnail"]]];
}

- (void)failLoadAdInfo {
    
}

#pragma mark - btnAction

- (void)praiseAction:(UIButton *)sender {
    
}

- (void)unpraiseAction:(UIButton *)sender {
    
}

- (void)introduceShowAction:(UIButton *)sender {
    
}

#pragma mark - lazyLoad

- (UIImageView *)adImgView {
    if (!_adImgView) {
        _adImgView = [[UIImageView alloc] init];
        _adImgView.layer.cornerRadius = 5.0;
        _adImgView.layer.masksToBounds = YES;
        _adImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _adImgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:20];
        _nameLabel.textColor = COLORWITHRGBADIVIDE255(51, 51, 51, 1);
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = COLORWITHRGBADIVIDE255(194, 154, 104, 1);
    }
    return _timeLabel;
}

- (UIButton *)praiseBtn {
    if (!_praiseBtn) {
        _praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_praiseBtn setImage:[UIImage imageNamed:@"praise_unpress"] forState:UIControlStateNormal];
        [_praiseBtn setImage:[UIImage imageNamed:@"praise_press"] forState:UIControlStateSelected];
        [_praiseBtn addTarget:self action:@selector(praiseAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _praiseBtn;
}

- (UIButton *)unpraiseBtn {
    if (!_unpraiseBtn) {
        _unpraiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_unpraiseBtn setImage:[UIImage imageNamed:@"unpraise_unpress"] forState:UIControlStateNormal];
        [_unpraiseBtn setImage:[UIImage imageNamed:@"unpraise_press"] forState:UIControlStateSelected];
        [_unpraiseBtn addTarget:self action:@selector(unpraiseAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unpraiseBtn;
}

- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc] init];
        _progressView.backgroundColor = COLORWITHRGBADIVIDE255(194, 154, 104, 1);
        _progressView.layer.cornerRadius = 3.0;
        _progressView.layer.masksToBounds = YES;
    }
    return _progressView;
}

- (UIView *)progressBGView {
    if (!_progressBGView) {
        _progressBGView = [[UIView alloc] init];
        _progressBGView.backgroundColor = COLORWITHRGBADIVIDE255(241, 242, 227, 1);
        _progressBGView.layer.cornerRadius = 3.0;
        _progressBGView.layer.masksToBounds = YES;
    }
    return _progressBGView;
}
- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.font = [UIFont systemFontOfSize:12];
        _progressLabel.textColor = COLORWITHRGBADIVIDE255(194, 154, 104, 1);
    }
    return _progressLabel;
}

- (UIView *)introduceView {
    if (!_introduceView) {
        _introduceView = [[UIView alloc] init];
        _introduceView.backgroundColor = COLORWITHRGBADIVIDE255(241, 242, 227, 1);
        _introduceView.layer.cornerRadius = 5.0;
        _introduceView.layer.masksToBounds = YES;
    }
    return _introduceView;
}

- (UILabel *)introduceLabel {
    if (!_introduceLabel) {
        _introduceLabel = [[UILabel alloc] init];
        _introduceLabel.font = [UIFont systemFontOfSize:12];
        _introduceLabel.numberOfLines = 3;
        _introduceLabel.textColor = COLORWITHRGBADIVIDE255(107, 107, 107, 1);
    }
    return _introduceLabel;
}

- (UIButton *)introduceBtn {
    if (!_introduceBtn) {
        _introduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_introduceBtn setTitle:@"简介" forState:UIControlStateNormal];
        [_introduceBtn setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
        [_introduceBtn addTarget:self action:@selector(introduceShowAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _introduceBtn;
}

@end
