//
//  NSDictionary+JSON.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)

- (NSString *)toJSONString;

- (NSString *)toJSONStringWithoutPrinted;

// 验证去除空字符串
- (NSMutableDictionary *)HandleString;

@end
