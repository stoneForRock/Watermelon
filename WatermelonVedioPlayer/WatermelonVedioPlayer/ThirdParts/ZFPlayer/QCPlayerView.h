//
//  QCPlayerView.h
//
// Copyright (c) 2016年 任子丰 ( http://github.com/renzifeng )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "QCPlayer.h"
#import "QCPlayerControlView.h"
#import "QCPlayerModel.h"
#import "QCPlayerControlViewDelegate.h"

// playerLayer的填充模式（默认：等比例填充，直到一个维度到达区域边界）
typedef NS_ENUM(NSInteger, QCPlayerLayerGravity) {
     QCPlayerLayerGravityResize,           // 非均匀模式。两个维度完全填充至整个视图区域
     QCPlayerLayerGravityResizeAspect,     // 等比例填充，直到一个维度到达区域边界
     QCPlayerLayerGravityResizeAspectFill  // 等比例填充，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪
};

// 播放器的几种状态
typedef NS_ENUM(NSInteger, QCPlayerState) {
    QCPlayerStateFailed,     // 播放失败
    QCPlayerStateBuffering,  // 缓冲中
    QCPlayerStatePlaying,    // 播放中
    QCPlayerStateStopped,    // 停止播放
    QCPlayerStatePause       // 暂停播放
};

@class QCPlayerView;
@protocol QCPlayerDelegate <NSObject>
@optional
/** 返回按钮事件 */
- (void)zf_playerBackAction;
/** 下载视频 */
- (void)zf_playerDownload:(NSString *)url;
/** 控制层即将显示 */
- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen;
/** 控制层即将隐藏 */
- (void)zf_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen;

/** 播放状态变化 */
- (void)zf_playStateChanged:(QCPlayerView *)playerView state:(QCPlayerState)state;

/** 购买按钮事件 */
- (void)zf_payAction;

/** 购买按钮事件 */
- (void)zf_guidPayAction;
/** 视频播放进程*/
- (void)zf_player:(NSTimeInterval)totalTime currentTime:(NSTimeInterval)currentTime;

@end

@interface QCPlayerView : UIView <QCPlayerControlViewDelagate>

/** 设置playerLayer的填充模式 */
@property (nonatomic, assign) QCPlayerLayerGravity    playerLayerGravity;
/** 是否有下载功能(默认是关闭) */
@property (nonatomic, assign) BOOL                    hasDownload;
/** 是否开启预览图 */
@property (nonatomic, assign) BOOL                    hasPreviewView;
/** 设置代理 */
@property (nonatomic, weak) id<QCPlayerDelegate>      delegate;
/** 是否被用户暂停 */
@property (nonatomic, assign, readonly) BOOL          isPauseByUser;
/** 播发器的几种状态 */
@property (nonatomic, assign, readonly) QCPlayerState state;
/** 静音（默认为NO）*/
@property (nonatomic, assign) BOOL                    mute;
/** 当cell划出屏幕的时候停止播放（默认为NO） */
@property (nonatomic, assign) BOOL                    stopPlayWhileCellNotVisable;
/** 当cell播放视频由全屏变为小屏时候，是否回到中间位置(默认YES) */
@property (nonatomic, assign) BOOL                    cellPlayerOnCenter;
/** player在栈上，即此时push或者模态了新控制器 */
@property (nonatomic, assign) BOOL                    playerPushedOrPresented;

/** 是否为全屏 */
@property (nonatomic, assign) BOOL                   isFullScreen;

/**
 *  单例，用于列表cell上多个视频
 *
 *  @return QCPlayer
 */
+ (instancetype)sharedPlayerView;

/**
 * 指定播放的控制层和模型
 * 控制层传nil，默认使用QCPlayerControlView(如自定义可传自定义的控制层)
 */
- (void)playerControlView:(UIView *)controlView playerModel:(QCPlayerModel *)playerModel;

/**
 * 使用自带的控制层时候可使用此API
 */
- (void)playerModel:(QCPlayerModel *)playerModel;

/**
 *  自动播放，默认不自动播放
 */
- (void)autoPlayTheVideo;

/**
 *  重置player
 */
- (void)resetPlayer;

// 全局强制停止
+ (void)forceStopPlay;

/**
 *  在当前页面，设置新的视频时候调用此方法
 */
- (void)resetToPlayNewVideo:(QCPlayerModel *)playerModel;

/**
 *  播放
 */
- (void)play;

/**
  * 暂停
 */
- (void)pause;



#pragma mark - 放置.h 方便子类重写

@property (nonatomic, strong) UIView                 *controlView;
@property (nonatomic, strong) QCPlayerModel          *playerModel;

/**
 *  屏幕方向发生变化会调用这里
 */
- (void)onDeviceOrientationChange;

/** 全屏 */
- (void)_fullScreenAction;


/**
 *  播放完了
 *
 *  @param notification 通知
 */
- (void)moviePlayDidEnd:(NSNotification *)notification;

/**
 *  player添加到fatherView上
 */
- (void)addPlayerToFatherView:(UIView *)view;

// 当前播放时间
- (NSInteger)playerCurrentTime;


@end
