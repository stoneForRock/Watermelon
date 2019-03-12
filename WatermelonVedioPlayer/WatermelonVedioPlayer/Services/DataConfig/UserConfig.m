//
//  UserConfig.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "UserConfig.h"
#import "BaseRequest.h"

#define kConfigUser @"config_user"

@implementation UserConfig

+ (UserConfig *)sharedConfig {
    static dispatch_once_t once;
    static UserConfig *shareConfig;
    dispatch_once(&once, ^{
        shareConfig = [[self alloc] init];
    });
    return shareConfig;
}

- (id)init {
    self = [super init];
    if (self) {
        self.firstProtectedDataAvailable = [UIApplication sharedApplication].protectedDataAvailable;
        [self loadConfig];
    }
    return self;
}

- (void)loadConfig {
    NSData *user = [[NSUserDefaults standardUserDefaults] objectForKey:kConfigUser];
    if (user) {
        self.user = [NSKeyedUnarchiver unarchiveObjectWithData:user];
        self.firstProtectedDataAvailable = YES;
    } else {
        self.user = [[APPUser alloc] init];
    }
}

- (void)clearConfig {
    self.user.token = @"";
    self.user = nil;
    [self saveConfig];
}

- (BOOL)saveConfig {
    if (self.user != nil) {
        NSData *user = [NSKeyedArchiver archivedDataWithRootObject:self.user];
        [[NSUserDefaults standardUserDefaults] setObject:user forKey:kConfigUser];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kConfigUser];
    }
    BOOL result = [[NSUserDefaults standardUserDefaults] synchronize];
    
    return result;
}


@end
