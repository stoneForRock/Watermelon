//
//  PublicConfig.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>
//微信appId 分享 支付用的
extern NSString *const  WECHAT_APPID;

#ifdef DEBUG
extern NSString *const  kGtAppID;
extern NSString *const  kGtAppSecret;
extern NSString *const  kGtAppKey;
extern NSString *const  kGtMasterSecret;
#else
extern NSString *const  kGtAppID;
extern NSString *const  kGtAppSecret;
extern NSString *const  kGtAppKey;
extern NSString *const  kGtMasterSecret;
#endif

// 七牛空间上传
extern NSString *const  qiNiuAccountSpace;
extern NSString *const  qiNiuDeafultSpace;
extern NSString *const  qiNiuOrderSpace;

extern NSString *const  kAppBundleIdProduct;
extern NSString *const  kPushClientId;

extern NSString *const _APPNAME;

#define AppWindow [[[UIApplication sharedApplication] delegate] window]

/**
 配置应用各种数据 比如 高德key 应用名称等
 */
@interface PublicConfig : NSObject

+ (NSString *)gaodeMapKey;

+ (BOOL)isProductMode;
+ (NSString *)visibleClientVersion;
+ (NSString *)clientVersion;
+ (NSString *)userAgent;

BOOL validEmail(NSString *email);

+ (BOOL)hasChinese:(NSString *)string;
+ (BOOL)isPhoneNumber:(NSString *)word;

+ (void)setExtraCellLineHiden:(UITableView *)tableView;

@end
