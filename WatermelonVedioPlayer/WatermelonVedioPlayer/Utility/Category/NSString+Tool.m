//
//  NSString+Tool.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "NSString+Tool.h"

@implementation NSString (Tool)

- (CGSize)sc_sizeForMaxWidth:(CGFloat)width
                        font:(UIFont *)font
{
    return [self sc_sizeForMaxWidth:width font:font numberOfLines:0];
}

- (CGSize)sc_sizeForMaxWidth:(CGFloat)width
                        font:(UIFont *)font
               numberOfLines:(int)numberOfLines
{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, numberOfLines == 0 ? CGFLOAT_MAX : [font pointSize] * (numberOfLines + 1))
                                     options:NSLineBreakByWordWrapping | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName: font}
                                     context:nil];
    rect.size.width = ceil(rect.size.width);
    rect.size.height = ceil(rect.size.height);
    return rect.size;
    //
    //        UILabel *gettingSizeLabel = [[UILabel alloc] init];
    //        gettingSizeLabel.font = font;
    //        gettingSizeLabel.text = self;
    //        gettingSizeLabel.numberOfLines = numberOfLines;
    //        CGSize maximumLabelSize = CGSizeMake(width, CGFLOAT_MAX);
    //        CGSize expectSize = [gettingSizeLabel sizeThatFits:maximumLabelSize];
    //        return expectSize;
}

- (CGSize)sc_sizeWithFont:(UIFont *)font
{
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}

- (NSMutableDictionary *)sc_queryComponents
{
    NSArray *queryComp = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    for (NSString *component in queryComp) {
        NSArray *subcomponents = [component componentsSeparatedByString:@"="];
        if (subcomponents.count > 1) {
            [parameters setObject:[[subcomponents objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                           forKey:[[subcomponents objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    return parameters;
}

//NSString *sc_safeString(NSString *str)
//{
//    if ([str isKindOfClass:[NSNull class]] || str == nil) {
//        return @"";
//    }
//    return str;
//}

- (NSString *)sc_stringByTrimmingWhitespaceAndNewlines
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSDate *)sc_dateValue
{
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
    }
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *date = [formatter dateFromString:self];
    if (!date)
    {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        date = [formatter dateFromString:self];
    }
    return date;
}

- (NSArray *)sc_rangesOfString:(NSString *)searchString {
    NSMutableArray *results = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, [self length]);
    NSRange range;
    while ((range = [self rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        [results addObject:[NSValue valueWithRange:range]];
        searchRange = NSMakeRange(NSMaxRange(range), [self length] - NSMaxRange(range));
    }
    return results;
}

+ (NSString *)sc_stringFileSizeWithValue:(double)dValue
{
    double convertedValue = dValue;
    int multiplyFactor = 0;
    
    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",nil];
    
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    if (multiplyFactor < tokens.count) {
        return [NSString stringWithFormat:@"%.1f%@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
    } else {
        return nil;
    }
}

- (NSArray *)sc_forEachString {
    NSRange theRange = {0, 1};
    NSMutableArray * array = [NSMutableArray array];
    for ( NSInteger i = 0; i < [self length]; i++) {
        theRange.location = i;
        [array addObject:[self substringWithRange:theRange]];
    }
    return array;
}

- (NSUInteger)sc_bytes {
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

//限制textField输入的长度
+ (void)restrictionInputTextField:(UITextField *)inputClass maxNumber:(NSInteger)maxNumber{
    //    NSString *toBeString = inputClass.text;
    NSString *lang = [[inputClass textInputMode] primaryLanguage]; // 获取当前键盘输入模式
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入,第三方输入法（搜狗）所有模式下都会显示“zh-Hans”
        UITextRange *selectedRange = [inputClass markedTextRange];
        //获取高亮部分
        UITextPosition *position = [inputClass positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            
            if (inputClass.text.length > maxNumber) {
                inputClass.text = [inputClass.text substringToIndex:maxNumber];
            }
        }
    } else{
        
        if (inputClass.text.length > maxNumber) {
            inputClass.text = [inputClass.text substringToIndex:maxNumber];
        }
    }
    
}

//textView输入框的限制 最大输入的字符长度
+ (void)restrictionInputTextView:(UITextView *)inputClass maxNumber:(NSInteger)maxNumber;
{
    NSString *lang = [[inputClass textInputMode] primaryLanguage]; // 获取当前键盘输入模式
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入,第三方输入法（搜狗）所有模式下都会显示“zh-Hans”
        UITextRange *selectedRange = [inputClass markedTextRange];
        //获取高亮部分
        UITextPosition *position = [inputClass positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            
            if (inputClass.text.length > maxNumber) {
                inputClass.text = [inputClass.text substringToIndex:maxNumber];
            }
        }
    } else{
        
        if (inputClass.text.length > maxNumber) {
            inputClass.text = [inputClass.text substringToIndex:maxNumber];
        }
    }
}

#pragma mark------判断是否是11位的纯数字
+(BOOL)clCheckPhoneNumberLength:(NSString *)input{
    //    NSString *inputRegex = @"^1\\d{10}$";
    //    NSPredicate *inputPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",inputRegex];
    NSString *inputRegex = @"^[0-9]*$";
    NSPredicate *inputPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",inputRegex];
    //    return [inputPredicate evaluateWithObject:input];
    
    if ([inputPredicate evaluateWithObject:input]) {
        if ([input length] == 11) {
            if ([[input substringToIndex:1] intValue] == 1) {
                return YES;
            }else{
                return NO;
            }
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

/**
 判断输入的是否是纯数字
 
 @param input 输入的内容
 @return 是否符合的结果
 */
+(BOOL)clCheckNumberInput:(NSString *)input
{
    NSString *inputRegex = @"^[0-9]*$";
    NSPredicate *inputPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",inputRegex];
    return [inputPredicate evaluateWithObject:input];
}

@end
