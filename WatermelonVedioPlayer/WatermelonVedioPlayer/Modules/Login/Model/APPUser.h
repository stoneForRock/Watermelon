//
//  APPUser.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface APPUser : JSONModel<NSCoding>

@property (nonatomic, copy) NSString *deviceUID;//设备唯一识别号
@property (nonatomic, copy) NSString *visitorToken;//未登录 是游客token

@property (nonatomic, copy) NSString<Optional> *userId;
@property (nonatomic, copy) NSString<Optional> *token;//正式token
@property (nonatomic, copy) NSString<Optional> *phone;
@property (nonatomic, copy) NSString<Optional> *password;
@property (nonatomic, copy) NSString<Optional> *name;
@property (nonatomic, copy) NSString<Optional> *avatar;
@property (nonatomic, copy) NSString<Optional> *accountType;
@property (nonatomic, copy) NSString<Optional> *createBy;
@property (nonatomic, copy) NSString<Optional> *createTime;
@property (nonatomic, copy) NSString<Optional> *serial;
@property (nonatomic, copy) NSString<Optional> *status;

- (NSString *)getRequestToken;

@end
