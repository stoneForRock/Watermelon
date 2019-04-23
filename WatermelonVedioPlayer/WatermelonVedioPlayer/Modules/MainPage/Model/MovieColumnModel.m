//
//  MovieColumnModel.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/14.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MovieColumnModel.h"

@implementation MovieColumnModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"cover": @"cover",
                                                       @"movies": @"movies",
                                                       @"name": @"name",
                                                       @"navId": @"navId",
                                                       @"navImage": @"navImage",
                                                       @"intro": @"intro",
                                                       @"lastUpdateTime": @"lastUpdateTime",
                                                       }];
}

- (instancetype)initWithChannelColumnDic:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.cover = dictionary[@"cover"]?dictionary[@"cover"]:@"";
        self.navId = dictionary[@"id"]?dictionary[@"id"]:@"";
        self.navImage = dictionary[@"navImage"]?dictionary[@"navImage"]:@"";
        self.name = dictionary[@"navName"]?dictionary[@"navName"]:@"";
        self.intro = dictionary[@"intro"]?dictionary[@"intro"]:@"";
        self.lastUpdateTime = dictionary[@"lastUpdateTime"]?dictionary[@"lastUpdateTime"]:@"";
    }
    return self;
}

@end
