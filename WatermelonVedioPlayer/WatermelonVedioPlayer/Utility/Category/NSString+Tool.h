//
//  NSString+Tool.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Tool)
// this method is for calculating the actual size for a given width on a multi-line label
- (CGSize)sc_sizeForMaxWidth:(CGFloat)width
                        font:(UIFont *)font
               numberOfLines:(int)numberOfLines;
- (CGSize)sc_sizeForMaxWidth:(CGFloat)width
                        font:(UIFont *)font;
- (CGSize)sc_sizeWithFont:(UIFont *)font;
- (NSMutableDictionary *)sc_queryComponents;
//NSString *sc_safeString(NSString *str);
- (NSString *)sc_stringByTrimmingWhitespaceAndNewlines;
/**
 *  兼容 yyyy-MM-dd HH:mm:ss 和 yyyy-MM-dd HH:mm:ss.SSS
 *
 *  @return 符合特定规格的时间NSDate
 */
- (NSDate *)sc_dateValue;
- (NSArray *)sc_rangesOfString:(NSString *)searchString;
+ (NSString *)sc_stringFileSizeWithValue:(double)dValue;
- (NSArray *)sc_forEachString;
- (NSUInteger)sc_bytes;

/**
 限制textField最大输入的字数  适配系统输入法和第三方输入法
 
 @param inputClass 输入的字符串
 @param maxNumber 最大限制数
 */
+ (void)restrictionInputTextField:(UITextField *)inputClass maxNumber:(NSInteger)maxNumber;

/**
 限制textView最大输入的字数  适配系统输入法和第三方输入法
 
 @param inputClass 输入的字符串
 @param maxNumber 最大限制数
 */
+ (void)restrictionInputTextView:(UITextView *)inputClass maxNumber:(NSInteger)maxNumber;

/**
 判断是否是以1开头的11位数字（手机号码）
 
 @param input 需要判断的字符串
 @return 是否符合的结果
 */
+(BOOL)clCheckPhoneNumberLength:(NSString *)input;

/**
 判断输入的是否是纯数字
 
 @param input 输入的内容
 @return 是否符合的结果
 */
+(BOOL)clCheckNumberInput:(NSString *)input;
@end
