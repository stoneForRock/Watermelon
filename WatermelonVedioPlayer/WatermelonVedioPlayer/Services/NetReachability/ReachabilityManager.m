//
//  ReachabilityManager.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "ReachabilityManager.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>

NSString *const ReachabilityDidChangeNotification = @"ReachabilityDidChangeNotification";
NSString *const ReachabilityStatusKey = @"ReachabilityStatusKey";
NSString *const ReachabilityStatusDescriptionKey = @"ReachabilityStatusDescriptionKey";

static NSString *const DReachabilityStatusUnknownDescription = @"UNKNOWN";
static NSString *const ReachabilityStatusNotReachableDescription = @"NONE";
static NSString *const ReachabilityStatusWiFiDescription = @"WIFI";
static NSString *const ReachabilityStatus4GDescription = @"4G";
static NSString *const ReachabilityStatus3GDescription = @"3G";
static NSString *const ReachabilityStatus2GDescription = @"2G";
static NSString *const ReachabilityStatusGPRSDescription = @"GPRS";

@implementation ReachabilityManager
+ (instancetype)sharedManager {
    static dispatch_once_t pred;
    static ReachabilityManager *instance = nil;
    
    dispatch_once(&pred, ^{
        instance = [[ReachabilityManager alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    
    if (self) {}
    return self;
}

- (ReachabilityStatus)reachabilityStatus {
    
    ReachabilityStatus reachabilityStatus = ReachabilityStatusUnknown;
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    AFNetworkReachabilityStatus networkStatus = manager.networkReachabilityStatus;
    
    if (networkStatus == AFNetworkReachabilityStatusReachableViaWiFi) {
        reachabilityStatus = ReachabilityStatusReachableViaWiFi;
    }
    else if (networkStatus == AFNetworkReachabilityStatusReachableViaWWAN) {
        reachabilityStatus = ReachabilityStatusReachableViaWWAN;
    }
    else if (networkStatus == AFNetworkReachabilityStatusNotReachable) {
        reachabilityStatus = ReachabilityStatusNotReachable;
    }
    
    return reachabilityStatus;
}

- (NSString *)reachabilityStatusDescription {
    NSString *reachabilityStatusDescription = DReachabilityStatusUnknownDescription;
    
    switch (self.reachabilityStatus) {
        case ReachabilityStatusNotReachable:
            reachabilityStatusDescription = ReachabilityStatusNotReachableDescription;
            break;
            
        case ReachabilityStatusReachableViaWWAN:
        {
            CTTelephonyNetworkInfo *telephonyInfo = [CTTelephonyNetworkInfo new];
            
            if ([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]) {
                reachabilityStatusDescription = ReachabilityStatusGPRSDescription;
            }
            else if ([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge]) {
                reachabilityStatusDescription = ReachabilityStatus2GDescription;
            }
            else if ([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
                reachabilityStatusDescription = ReachabilityStatus4GDescription;
            }
            else {
                reachabilityStatusDescription = ReachabilityStatus3GDescription;
            }
        }
            break;
            
        case ReachabilityStatusReachableViaWiFi:
            reachabilityStatusDescription = ReachabilityStatusWiFiDescription;
            break;
            
        default:
            break;
    }
    return reachabilityStatusDescription;
}

- (void)startMonitoring {
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    __weak __typeof(self) weakSelf = self;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ReachabilityDidChangeNotification object:nil userInfo:@{ReachabilityStatusKey : @(weakSelf.reachabilityStatus), ReachabilityStatusDescriptionKey : weakSelf.reachabilityStatusDescription}];
    }];
    
    [manager startMonitoring];
}

- (void)stopMonitoring {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager stopMonitoring];
}

- (BOOL)isReachable {
    return self.reachabilityStatus == ReachabilityStatusReachableViaWWAN || self.reachabilityStatus == ReachabilityStatusReachableViaWiFi;
}
@end
