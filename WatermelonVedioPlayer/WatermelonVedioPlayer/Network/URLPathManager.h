//
//  URLPathManager.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const URLChangeNotification;

typedef NS_ENUM(NSUInteger, URLType) {
    URLTypeProduction = 1,//正式环境
    URLTypeTest = 2,      //测试环境
    URLTypeDev = 3,       //开发环境
};

#define _URLPathManager [URLPathManager sharedURLPathManager]

@interface URLPathManager : NSObject

@property (assign, nonatomic) URLType urlType;

+ (instancetype)sharedURLPathManager;

- (NSString *)baseUrl;
- (NSString *)baseUrlWithoutTLS;

@end
