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

@end
