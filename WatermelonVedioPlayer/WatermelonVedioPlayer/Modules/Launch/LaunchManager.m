//
//  LaunchManager.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/18.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "LaunchManager.h"
#import <AVFoundation/AVFoundation.h>
#import<libkern/OSAtomic.h>
#import <stdatomic.h>
#import "AppDelegate.h"

@interface LaunchManager ()

@end

@implementation LaunchManager

+ (void)didFinishLaunching {
    [self showHubLaunchImage];
}

+ (void)showHubLaunchImage {
    NSString *launchImageName = @"LaunchImage";
    __block UIImageView *launchImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    launchImageView.userInteractionEnabled = YES;
    launchImageView.tag = 19839;
    launchImageView.image = [UIImage imageNamed:launchImageName];
    [[AppDelegate getAppDelegate].window addSubview:launchImageView];
    
    UITapGestureRecognizer *tapLaunchRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLaunchAction)];
    [launchImageView addGestureRecognizer:tapLaunchRecognizer];
}

+ (void)showTimeOutCount {
    UIImageView *launchImageView = [[AppDelegate getAppDelegate].window viewWithTag:19839];
    __block atomic_int timeOutCount = 5;//5秒倒计时
    __block UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTitle:[NSString stringWithFormat:@"%d",timeOutCount] forState:UIControlStateNormal];
    [closeBtn setBackgroundColor:COLORWITHRGBADIVIDE255(244, 244, 244, 1)];
    [closeBtn setTitleColor:COLORWITHRGBADIVIDE255(68, 68, 68, 1) forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 80, 80, 60, 60);
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.enabled = NO;
    closeBtn.layer.cornerRadius = 30.0;
    closeBtn.layer.masksToBounds = YES;
    [launchImageView addSubview:closeBtn];
    
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        atomic_fetch_sub(&timeOutCount,1);
        [closeBtn setTitle:[NSString stringWithFormat:@"%d",timeOutCount] forState:UIControlStateNormal];
        if (timeOutCount == 0) {
            dispatch_source_cancel(timer);
        }
    });
    
    dispatch_source_set_cancel_handler(timer, ^{
        closeBtn.enabled = YES;
        [closeBtn setTitle:@"" forState:UIControlStateNormal];
        [closeBtn setImage:[UIImage imageNamed:@"close_small_icon"] forState:UIControlStateNormal];
    });
    
    dispatch_resume(timer);
}

- (void)closeAction {
    UIImageView *launchImageView = [[AppDelegate getAppDelegate].window viewWithTag:19839];
    [launchImageView removeFromSuperview];
    launchImageView = nil;
}

//点击启动图
- (void)tapLaunchAction {
    
}

@end
