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
                                                       }];
}

@end
