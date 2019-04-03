//
//  MoivesModel.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MoivesModel.h"

@implementation MoivesModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"cover": @"cover",
                                                       @"createTime": @"createTime",
                                                       @"dislikeCnt": @"dislikeCnt",
                                                       @"file": @"file",
                                                       @"id": @"moiveId",
                                                       @"loveCnt": @"loveCnt",
                                                       @"movCls": @"movCls",
                                                       @"movDesc": @"movDesc",
                                                       @"movName": @"movName",
                                                       @"movScore": @"movScore",
                                                       @"playCount": @"playCount",
                                                       @"status": @"status",
                                                       @"updateTime": @"updateTime",
                                                       }];
}

- (instancetype)initWithDetailDictionary:(NSDictionary *)movieDic {
    self = [super initWithDictionary:movieDic error:nil];
    if (self) {
        self.createTime = movieDic[@"createDate"]?movieDic[@"createDate"]:@"";
        self.duration = movieDic[@"duration"]?movieDic[@"duration"]:@"";
        self.durationStr = movieDic[@"durationStr"]?movieDic[@"durationStr"]:@"";
        self.isFav = movieDic[@"isFav"]?movieDic[@"isFav"]:@"";
        self.loveStatus = movieDic[@"loveStatus"]?movieDic[@"loveStatus"]:@"";
        self.relTagName = movieDic[@"relTagName"]?movieDic[@"relTagName"]:@[];
    }
    return self;
}

@end
