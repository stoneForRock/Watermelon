//
//  NSObject+Safe.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "NSObject+Safe.h"

@implementation NSObject (Safe)

- (BOOL)sc_isNull {
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self length] == 0) {
            return YES;
        }
    } else if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    
    return NO;
}

- (NSString *)sc_safeString {
    if (!self || [self isEqual:[NSNull null]] || ![self isKindOfClass:[NSString class]]) {
        return @"";
    }
    return (NSString *)self;
}

- (NSNumber *)sc_safeNumber {
    if (!self || [self isEqual:[NSNull null]] || ![self isKindOfClass:[NSNumber class]]) {
        return @0;
    }
    return (NSNumber *)self;
}

- (NSArray *)sc_safeArray {
    if (!self || [self isEqual:[NSNull null]] || ![self isKindOfClass:[NSArray class]]) {
        return @[];
    }
    return (NSArray *)self;
}

@end
