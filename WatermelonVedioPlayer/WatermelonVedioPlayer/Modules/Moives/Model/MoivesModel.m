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

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.cover forKey:@"cover"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.dislikeCnt forKey:@"dislikeCnt"];
    [aCoder encodeObject:self.file forKey:@"file"];
    [aCoder encodeObject:self.moiveId forKey:@"moiveId"];
    [aCoder encodeObject:self.loveCnt forKey:@"loveCnt"];
    [aCoder encodeObject:self.movCls forKey:@"movCls"];
    [aCoder encodeObject:self.movDesc forKey:@"movDesc"];
    [aCoder encodeObject:self.movName forKey:@"movName"];
    [aCoder encodeObject:self.movScore forKey:@"movScore"];
    [aCoder encodeObject:self.playCount forKey:@"playCount"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.updateTime forKey:@"updateTime"];
    [aCoder encodeObject:self.duration forKey:@"duration"];
    [aCoder encodeObject:self.durationStr forKey:@"durationStr"];
    [aCoder encodeObject:self.isFav forKey:@"isFav"];
    [aCoder encodeObject:self.loveStatus forKey:@"loveStatus"];
    [aCoder encodeObject:self.relTagName forKey:@"relTagName"];
    
}
// 解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super init]) {
        self.cover = [aDecoder decodeObjectForKey:@"cover"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.dislikeCnt = [aDecoder decodeObjectForKey:@"dislikeCnt"];
        self.file = [aDecoder decodeObjectForKey:@"file"];
        self.moiveId = [aDecoder decodeObjectForKey:@"moiveId"];
        self.loveCnt = [aDecoder decodeObjectForKey:@"loveCnt"];
        self.movCls = [aDecoder decodeObjectForKey:@"movCls"];
        self.movDesc = [aDecoder decodeObjectForKey:@"movDesc"];
        self.movName = [aDecoder decodeObjectForKey:@"movName"];
        self.movScore = [aDecoder decodeObjectForKey:@"movScore"];
        self.playCount = [aDecoder decodeObjectForKey:@"playCount"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.updateTime = [aDecoder decodeObjectForKey:@"updateTime"];
        self.duration = [aDecoder decodeObjectForKey:@"duration"];
        self.durationStr = [aDecoder decodeObjectForKey:@"durationStr"];
        self.isFav = [aDecoder decodeObjectForKey:@"isFav"];
        self.loveStatus = [aDecoder decodeObjectForKey:@"loveStatus"];
        self.relTagName = [aDecoder decodeObjectForKey:@"relTagName"];
    }
    return self;
}


@end
