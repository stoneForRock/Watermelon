//
//  NSString+Formatter.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Formatter)

//获取唯一uuid
+ (NSString *)uuidString;

@end

@interface NSString (SCRegular)

- (BOOL)isNumText;
- (BOOL)isCountryPhone;

@end

@interface NSString (SCTimeFormatter)

- (NSString *)changeToDateStringWithformatter:(NSString *)fomatter;
- (NSDate *)changeToDate;
- (NSString *)changeSecondToDateStringWithformatter:(NSString *)fomatter;
//将时间戳转换为00点的时间戳
- (NSString *)changeToDateTimeInterval;

//获取最大 按2个字母为一个汉子长度，来获取字符串的长度 比如3个字母为2
- (NSInteger)getMaxStringLength;

//获取最小 按2个字母为一个汉子长度，来获取字符串的长度 比如3个字母为1
- (NSInteger)getMinStringLength;

@end

@interface NSString (SCSafeString)

- (NSString *)safeString;

- (NSString *)sc_trimWhitespaceAndNewline;

@end

@interface NSString (SCEncode)

- (NSString *)urlStringEncode;

@end

@interface NSString (SCStringSize)

- (CGSize)sizeWithFont:(UIFont *)font height:(CGFloat)height;

@end
