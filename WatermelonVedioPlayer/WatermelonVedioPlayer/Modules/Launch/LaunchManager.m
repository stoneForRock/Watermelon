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
#import <SDWebImage/UIImageView+WebCache.h>

@interface LaunchManager ()

@property (nonatomic, strong) NSMutableArray *adList;
@property (nonatomic, assign) NSInteger timeCount;

@end

@implementation LaunchManager

+ (instancetype)sharedLaunchManager
{
    static dispatch_once_t pred;
    static LaunchManager *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[LaunchManager alloc] init];
    });
    return instance;
}

- (void)didFinishLaunching {
    [self showHubLaunchImage];
}

- (void)showHubLaunchImage {
    NSString *launchImageName = @"LaunchImage";
    __block UIImageView *launchImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    launchImageView.userInteractionEnabled = YES;
    launchImageView.contentMode = UIViewContentModeScaleAspectFill;
    launchImageView.tag = 19839;
    launchImageView.image = [UIImage imageNamed:launchImageName];
    [[AppDelegate getAppDelegate].window addSubview:launchImageView];
    
    UITapGestureRecognizer *tapLaunchRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLaunchAction)];
    [launchImageView addGestureRecognizer:tapLaunchRecognizer];
}

- (void)showTimeOutCountWithAds:(NSArray *)ads {
    
    UIImageView *launchImageView = [[AppDelegate getAppDelegate].window viewWithTag:19839];
    __block atomic_int timeOutCount = 6;//5秒倒计时
    __block UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTitle:[NSString stringWithFormat:@"%d",timeOutCount] forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [closeBtn setBackgroundColor:COLORWITHRGBADIVIDE255(244, 244, 244, 1)];
    [closeBtn setTitleColor:COLORWITHRGBADIVIDE255(68, 68, 68, 1) forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 34, StatusBarHeight + 10, 24, 24);
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.enabled = NO;
    closeBtn.layer.cornerRadius = 12.0;
    closeBtn.layer.masksToBounds = YES;
    closeBtn.tag = 1009302;
    [launchImageView addSubview:closeBtn];
    
    if (ads && ads.count > 0) {
        self.adList = [NSMutableArray arrayWithArray:ads];
        NSString *imageUrlString = [[ads objectAtIndex:0] objectForKey:@"thumbnail"];
        [launchImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:@"LaunchImage"] options:SDWebImageRetryFailed];
    }
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        atomic_fetch_sub(&timeOutCount,1);
        [closeBtn setTitle:[NSString stringWithFormat:@"%d",timeOutCount] forState:UIControlStateNormal];
        self.timeCount = timeOutCount;
        if (timeOutCount == 0) {
            dispatch_source_cancel(timer);
        } else if (timeOutCount == 3) {
            if (ads && ads.count > 1) {
                NSString *imageUrlString = [[ads objectAtIndex:1] objectForKey:@"thumbnail"];
                [launchImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:@"LaunchImage"] options:SDWebImageRetryFailed];
            }
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
    if (self.adList && self.adList.count > 0) {
        if (self.timeCount < 3) {
            NSString *linkAddr = [[self.adList objectAtIndex:0] objectForKey:@"linkAddr"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkAddr] options:@{} completionHandler:nil];
        } else {
            if (self.adList.count  >1) {
                NSString *linkAddr = [[self.adList objectAtIndex:0] objectForKey:@"linkAddr"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkAddr] options:@{} completionHandler:nil];
            }
        }
    }
}

@end
