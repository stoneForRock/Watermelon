//
//  ReachabilityManager.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM (NSInteger, ReachabilityStatus) {
    ReachabilityStatusUnknown = -1,
    ReachabilityStatusNotReachable = 0,
    ReachabilityStatusReachableViaWWAN = 1,
    ReachabilityStatusReachableViaWiFi = 2,
};

/**
 *  [notification userInfo] =
 *
 *  {
 *      ReachabilityStatusKey : reachabilityStatus,
 *      ReachabilityStatusDescriptionKey : reachabilityStatusDescription
 *  }
 *
 */
FOUNDATION_EXPORT NSString *const ReachabilityDidChangeNotification;
FOUNDATION_EXPORT NSString *const ReachabilityStatusKey;
FOUNDATION_EXPORT NSString *const ReachabilityStatusDescriptionKey;

@interface ReachabilityManager : NSObject
@property (assign, nonatomic, readonly) ReachabilityStatus reachabilityStatus;
//return WIFI、4G、3G、2G、GPRS、NONE、UNKNOWN
@property (strong, nonatomic, readonly) NSString *reachabilityStatusDescription;

+ (instancetype)sharedManager;

- (void)startMonitoring;
- (void)stopMonitoring;
- (BOOL)isReachable;
@end
