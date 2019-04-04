//
//  MovieDetailInfoView.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/2.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MovieDetailInfoView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MoivesRequest.h"
#import "HUDHelper.h"

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

@property (nonatomic, strong) UIButton *loveBtn;
@property (nonatomic, strong) UIButton *downLoadBtn;
@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *gussLikeLabel;

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
        
        [self addSubview:self.loveBtn];
        [self addSubview:self.downLoadBtn];
        [self addSubview:self.shareBtn];
        
        [self addSubview:self.lineView];
        [self addSubview:self.gussLikeLabel];
        
        self.adImgView.frame = CGRectMake(15, 10, frame.size.width - 30, 80);
        self.nameLabel.frame = CGRectMake(15, CGRectGetMaxY(self.adImgView.frame) + 10, frame.size.width - 185, 40);
        self.timeLabel.frame = CGRectMake(15, CGRectGetMaxY(self.nameLabel.frame), frame.size.width - 30, 30);
        self.praiseBtn.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame) + 5, CGRectGetMinY(self.nameLabel.frame) + 8, 24, 24);
        self.progressBGView.frame = CGRectMake(CGRectGetMaxX(self.praiseBtn.frame) + 10, CGRectGetMinY(self.nameLabel.frame) + 10, 80, 6);
        self.progressLabel.frame = CGRectMake(CGRectGetMaxX(self.praiseBtn.frame) + 10, CGRectGetMaxY(self.progressBGView.frame), 80, 18);
        self.unpraiseBtn.frame = CGRectMake(CGRectGetMaxX(self.progressBGView.frame) + 10, CGRectGetMinY(self.nameLabel.frame) + 8, 24, 24);
        
        self.introduceView.frame = CGRectMake(15, CGRectGetMaxY(self.timeLabel.frame) + 10, frame.size.width - 30, 80);
        self.introduceLabel.frame = CGRectMake(15, 0, self.introduceView.frame.size.width - 75, 80);
        self.introduceBtn.frame = CGRectMake(CGRectGetMaxX(self.introduceLabel.frame), 0, 60, 80);
        
        self.loveBtn.frame = CGRectMake(frame.size.width - 155, CGRectGetMaxY(self.introduceView.frame) + 10, 27, 27);
        self.downLoadBtn.frame = CGRectMake(CGRectGetMaxX(self.loveBtn.frame) + 25, CGRectGetMaxY(self.introduceView.frame) + 10, 27, 27);
        self.shareBtn.frame = CGRectMake(CGRectGetMaxX(self.downLoadBtn.frame) + 25, CGRectGetMaxY(self.introduceView.frame) + 10, 27, 27);
        
        self.lineView.frame = CGRectMake(15, CGRectGetMaxY(self.loveBtn.frame) + 10, frame.size.width - 30, 0.5);
        self.gussLikeLabel.frame = CGRectMake(15, CGRectGetMaxY(self.lineView.frame) + 10, frame.size.width - 30, 40);
        
        UITapGestureRecognizer *tapAD = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAd:)];
        [self.adImgView addGestureRecognizer:tapAD];
    }
    return self;
}

- (void)setInfoModel:(MoivesModel *)infoModel {
    _infoModel = infoModel;
    self.nameLabel.text = infoModel.movName;
    self.timeLabel.text = [NSString stringWithFormat:@"%@ · %.2f万次播放",infoModel.createTime,[infoModel.playCount doubleValue]/10000];
    double likeCount = [infoModel.loveCnt doubleValue];
    double disLikeCnt = [infoModel.dislikeCnt doubleValue];
    double progress = likeCount/(likeCount + disLikeCnt);
    self.progressLabel.text = [NSString stringWithFormat:@"%.f%%觉得很赞",progress*100];
    self.progressView.frame = CGRectMake(0, 0, progress*self.progressBGView.bounds.size.width, self.progressBGView.bounds.size.height);
    self.introduceLabel.text = infoModel.movDesc;
    
    if ([infoModel.loveStatus integerValue] == 1) {
        self.praiseBtn.selected = YES;
        self.unpraiseBtn.selected = NO;
    } else if ([infoModel.loveStatus integerValue] == 2) {
        self.praiseBtn.selected = NO;
        self.unpraiseBtn.selected = YES;
    } else {
        self.praiseBtn.selected = NO;
        self.unpraiseBtn.selected = NO;
    }
    
    if ([infoModel.isFav boolValue]) {
        self.loveBtn.selected = YES;
    } else {
        self.loveBtn.selected = NO;
    }
}

- (void)setAdInfo:(NSDictionary *)adInfo {
    _adInfo = adInfo;
    [self.adImgView sd_setImageWithURL:[NSURL URLWithString:adInfo[@"thumbnail"]]];
}

- (void)failLoadAdInfo {
    
}

#pragma mark - btnAction

- (void)tapAd:(UIGestureRecognizer *)gesture {
    if (self.adInfo) {
        NSString *urlString = self.adInfo[@"linkAddr"]?self.adInfo[@"linkAddr"]:@"";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
    }
}

- (void)praiseAction:(UIButton *)sender {
    //没有点过赞或者踩的，才可以操作
    if ([self.infoModel.loveStatus intValue] == 0) {
        sender.selected = YES;
        [MoivesRequest praiseMovieWithId:self.infoModel.moiveId status:@"1" finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
            if (success) {
                self.infoModel.loveStatus = @"1";
            } else {
                [HUDHelper showHUDText:error.domain duration:1.5 inView:self];
                self.praiseBtn.selected = NO;
            }
        }];
    }
}

- (void)unpraiseAction:(UIButton *)sender {
    if ([self.infoModel.loveStatus intValue] == 0) {
        sender.selected = YES;
        [MoivesRequest praiseMovieWithId:self.infoModel.moiveId status:@"2" finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
            if (success) {
                self.infoModel.loveStatus = @"2";
            } else {
                [HUDHelper showHUDText:error.domain duration:1.5 inView:self];
                self.unpraiseBtn.selected = NO;
            }
        }];
    }
}

- (void)introduceShowAction:(UIButton *)sender {
    if (self.infoViewDelegate != nil && [self.infoViewDelegate respondsToSelector:@selector(showIntroduceMovie:)]) {
        [self.infoViewDelegate showIntroduceMovie:self.infoModel];
    }
}

- (void)loveAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [MoivesRequest addFavMovieWithId:self.infoModel.moiveId finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
            if (success) {
                self.infoModel.isFav = @"1";
            } else {
                [HUDHelper showHUDText:error.domain duration:1.5 inView:self];
                self.loveBtn.selected = NO;
            }
        }];
    } else {
        [MoivesRequest cancelFavMovieWithId:self.infoModel.moiveId finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
            if (success) {
                self.infoModel.isFav = @"0";
            } else {
                [HUDHelper showHUDText:error.domain duration:1.5 inView:self];
                self.loveBtn.selected = YES;
            }
        }];
    }
    
}

- (void)downLoadAction:(UIButton *)sender {
    if (self.infoViewDelegate != nil && [self.infoViewDelegate respondsToSelector:@selector(dwonLoadMovie:)]) {
        [self.infoViewDelegate dwonLoadMovie:self.infoModel];
    }
}

- (void)shareAction:(UIButton *)sender {
    if (self.infoViewDelegate != nil && [self.infoViewDelegate respondsToSelector:@selector(shareMovie:)]) {
        [self.infoViewDelegate shareMovie:self.infoModel];
    }
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
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
        _nameLabel.textColor = COLORWITHRGBADIVIDE255(51, 51, 51, 1);
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = COLORWITHRGBADIVIDE255(51, 51, 51, 1);
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
        _progressLabel.font = [UIFont systemFontOfSize:9];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
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
        _introduceBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_introduceBtn setTitle:@"简介" forState:UIControlStateNormal];
        [_introduceBtn setTitleColor:COLORWITHRGBADIVIDE255(194, 154, 104, 1) forState:UIControlStateNormal];
        [_introduceBtn setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
        [_introduceBtn addTarget:self action:@selector(introduceShowAction:) forControlEvents:UIControlEventTouchUpInside];
        _introduceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        _introduceBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    }
    return _introduceBtn;
}

- (UIButton *)loveBtn {
    if (!_loveBtn) {
        _loveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loveBtn setImage:[UIImage imageNamed:@"favor_nopress"] forState:UIControlStateNormal];
        [_loveBtn setImage:[UIImage imageNamed:@"favor_press"] forState:UIControlStateSelected];
        [_loveBtn addTarget:self action:@selector(loveAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveBtn;
}

- (UIButton *)downLoadBtn {
    if (!_downLoadBtn) {
        _downLoadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downLoadBtn setImage:[UIImage imageNamed:@"download_nopress"] forState:UIControlStateNormal];
        [_downLoadBtn setImage:[UIImage imageNamed:@"download_press"] forState:UIControlStateSelected];
        [_downLoadBtn addTarget:self action:@selector(downLoadAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downLoadBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"send_nopress"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"send_press"] forState:UIControlStateSelected];
        [_shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = COLORWITHRGBADIVIDE255(241, 242, 227, 1);
    }
    return _lineView;
}

- (UILabel *)gussLikeLabel {
    if (!_gussLikeLabel) {
        _gussLikeLabel = [[UILabel alloc] init];
        _gussLikeLabel.textColor = COLORWITHRGBADIVIDE255(51, 51, 51, 1);
        _gussLikeLabel.font = [UIFont boldSystemFontOfSize:18];
        _gussLikeLabel.text = @"猜你喜欢";
    }
    return _gussLikeLabel;
}

@end
