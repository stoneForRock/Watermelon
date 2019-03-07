//
//  URLPathManager.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "URLPathManager.h"
//正式环境
static NSString *const URL = @"http://120.79.57.229:8071";

//Test
static NSString *const URL_TEST = @"http://120.79.57.229:8071";

//Dev
static NSString *const URL_Dev = @"http://120.79.57.229:8071";

NSString *const URLChangeNotification = @"URLChangeNotification";

//当前环境类型
#define kUrlType @"kUrlType"

@interface URLPathManager()
@property (strong, nonatomic) NSString *serverBaseUrl;
@end

@implementation URLPathManager

+ (instancetype)sharedURLPathManager
{
    static dispatch_once_t pred;
    static URLPathManager *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[URLPathManager alloc] init];
    });
    return instance;
}

- (NSString *)serverBaseUrl {
    if (_serverBaseUrl == nil) {
        switch ([self urlType]) {
            case URLTypeProduction:
                _serverBaseUrl = URL;
                break;
                
            case URLTypeTest:
                _serverBaseUrl = URL_TEST;
                break;
                
            case URLTypeDev:
                _serverBaseUrl = URL_Dev;
                break;
            default:
                _serverBaseUrl = URL;
                break;
        }
    }
    return _serverBaseUrl;
}

- (NSString *)baseUrl {
    return self.serverBaseUrl;
}

- (NSString *)baseUrlWithoutTLS {
    NSString *baseUrl = [self baseUrl];
    if ([baseUrl hasPrefix:@"https"]) {
        return [baseUrl stringByReplacingOccurrencesOfString:@"https" withString:@"http" options:NSAnchoredSearch range:NSMakeRange(0, baseUrl.length)];
    }
    return baseUrl;
}

- (URLType)urlType {
    int type = (int)[[NSUserDefaults standardUserDefaults] integerForKey:kUrlType];
    if (type == 0) {
        //设置默认值
        type = URLTypeProduction;
        [[NSUserDefaults standardUserDefaults] setInteger:type forKey:kUrlType];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return type;
}

- (void)setUrlType:(URLType)urlType {
    if (urlType != [self urlType]) {
        _serverBaseUrl = nil;
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:urlType forKey:kUrlType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:URLChangeNotification object:nil];
}
@end
