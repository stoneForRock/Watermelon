//
//  NSObject+Safe.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Safe)

- (BOOL)sc_isNull;
- (NSString *)sc_safeString;
- (NSNumber *)sc_safeNumber;
- (NSArray *)sc_safeArray;

@end
