//
//  MovieLiveView.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/29.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MovieLiveView.h"
#import "ZFPlayerView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MovieLiveView ()<ZFPlayerDelegate>

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
        self.adDowncountLabel.frame = CGRectMake(frame.size.width - 45, 10, 24, 24);
        
        UITapGestureRecognizer *tapADGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAd)];
        [self.videoADImgView addGestureRecognizer:tapADGesture];
    }
    return self;
}

- (void)tapAd {
    if (self.adInfo) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.adInfo[@"linkAddr"]] options:@{} completionHandler:nil];
    }
}

- (void)setMovieModel:(MoivesModel *)movieModel {
    _movieModel = movieModel;
}

- (void)setAdInfo:(NSDictionary *)adInfo {
    _adInfo = adInfo;
    [self.videoADImgView sd_setImageWithURL:[NSURL URLWithString:adInfo[@"thumbnail"]] placeholderImage:[UIImage imageNamed:@"LaunchImage"]];
    [self invalidateTimer];
    self.downCountTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDownCount) userInfo:nil repeats:YES];
    [self.downCountTimer fire];
}

- (void)failLoadAdInfo {
    [self playMovie:self.movieModel seekTime:0];
    [self.videoADImgView removeFromSuperview];
}

- (void)invalidateTimer {
    if (self.downCountTimer) {
        [self.downCountTimer invalidate];
        self.downCountTimer = nil;
    }
}

- (void)timeDownCount {
    int adDwonCount = [self.adDowncountLabel.text intValue];
    if (adDwonCount == 0) {
        [self invalidateTimer];
        [self playMovie:self.movieModel seekTime:0];
        [self.videoADImgView removeFromSuperview];
        [[NSNotificationCenter defaultCenter] postNotificationName:PlayerControlViewShow object:nil userInfo:@{@"show":@(0)}];
        return;
    }
    self.adDowncountLabel.text = [NSString stringWithFormat:@"%d",adDwonCount - 1];
}

- (void)startPlayMovie:(MoivesModel *)movieModel {
    _movieModel = movieModel;
}

- (void)playMovie:(MoivesModel *)movieModel seekTime:(NSInteger)seekTime {
    ZFPlayerView *player = [ZFPlayerView sharedPlayerView];
    player.delegate = self;
    ZFPlayerModel *playerModel = [ZFPlayerModel new];
    NSString *play_url = movieModel.file;
    // 视频
    playerModel.videoURL = [NSURL URLWithString:play_url];
    playerModel.fatherView = self;
    if (seekTime > 0) {
        playerModel.seekTime = seekTime;
    }
    [player playerControlView:nil playerModel:playerModel];
    [player resetToPlayNewVideo:playerModel];
}

- (void)resetPlayer {
    [[ZFPlayerView sharedPlayerView] resetPlayer];
}

#pragma mark - ZFPlayerDelegate
/** 控制层即将显示 */
- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
    [[NSNotificationCenter defaultCenter] postNotificationName:PlayerControlViewShow object:nil userInfo:@{@"show":@(1)}];
}

/** 控制层即将隐藏 */
- (void)zf_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
    [[NSNotificationCenter defaultCenter] postNotificationName:PlayerControlViewShow object:nil userInfo:@{@"show":@(0)}];
}

#pragma mark - lazyLoad

- (UIImageView *)videoADImgView {
    if (!_videoADImgView) {
        _videoADImgView = [[UIImageView alloc] init];
        _videoADImgView.contentMode = UIViewContentModeScaleAspectFill;
        _videoADImgView.userInteractionEnabled = YES;
        _videoADImgView.layer.masksToBounds = YES;
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
        _adDowncountLabel.text = @"5";
        _adDowncountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _adDowncountLabel;
}

@end
