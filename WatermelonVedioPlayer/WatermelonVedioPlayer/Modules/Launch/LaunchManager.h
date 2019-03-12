//
//  LaunchManager.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/18.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LaunchManager : NSObject

+ (instancetype)sharedLaunchManager;
- (void)didFinishLaunching;
- (void)showTimeOutCountWithAds:(NSArray *)ads;

@end
