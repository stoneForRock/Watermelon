//
//  APPUser.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "APPUser.h"

@implementation APPUser

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"object.id": @"userId",
                                                       @"token": @"token",
                                                       @"object.phone": @"phone",
                                                       @"object.accountPwd": @"password",
                                                       @"object.name": @"name",
                                                       @"object.pic": @"avatar",
                                                       @"object.accountType": @"accountType",
                                                       @"object.createBy": @"createBy",
                                                       @"object.createTime": @"createTime",
                                                       @"object.serial": @"serial",
                                                       @"object.status": @"status"
                                                       }];
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.accountType forKey:@"accountType"];
    [aCoder encodeObject:self.createBy forKey:@"createBy"];
    [aCoder encodeObject:self.createTime forKey:@"lastUpdateTime"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.serial forKey:@"serial"];
    [aCoder encodeObject:self.status forKey:@"status"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.accountType = [aDecoder decodeObjectForKey:@"accountType"];
        self.createBy = [aDecoder decodeObjectForKey:@"createBy"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.serial = [aDecoder decodeObjectForKey:@"serial"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
    }
    return self;
}


@end
