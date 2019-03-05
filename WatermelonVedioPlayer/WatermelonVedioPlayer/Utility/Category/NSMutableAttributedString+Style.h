//
//  NSMutableAttributedString+Style.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Style)

// 字体
- (void)sc_setFont:(UIFont *)font;
- (void)sc_setFont:(UIFont *)font range:(NSRange)range;

// 颜色
- (void)sc_setTextColor:(UIColor *)color;
- (void)sc_setTextColor:(UIColor *)color range:(NSRange)range;
- (void)sc_setTextColor:(UIColor *)color keyword:(NSString *)keyword;

// 对齐
- (void)sc_setTextAlignment:(NSTextAlignment)alignment;
- (void)sc_setTextAlignment:(NSTextAlignment)alignment range:(NSRange)range;

// 下划线
- (void)sc_setUnderline;
- (void)sc_setUnderlineWithRange:(NSRange)range;

// link
- (void)sc_setLinkWithRange:(NSRange)range URL:(NSURL *)URL;
+ (NSDictionary *)sc_linkAttributeWithLinkColor: (UIColor *)color;

// NSParagraphStyle
- (void)sc_setParagraphStyle:(NSParagraphStyle *)style;
- (void)sc_setParagraphStyle:(NSParagraphStyle *)style range:(NSRange)range;

// NSBaselineOffsetAttributeName
- (void)sc_setBaselineOffset:(CGFloat)fOffset;
- (void)sc_setBaselineOffset:(CGFloat)fOffset range:(NSRange)range;

// letter spacing
- (void)sc_setLetterSpacing:(CGFloat)fSpacing;
- (void)sc_setLetterSpacing:(CGFloat)fSpacing range:(NSRange)range;

// line spacing
- (void)sc_setLineSpacing:(CGFloat)fSpacing;
- (void)sc_setLineSpacing:(CGFloat)fSpacing range:(NSRange)range;

// image
- (void)sc_setImageWithName:(NSString *)imageName range:(NSRange)range;
- (void)sc_setImageWithName:(NSString *)imageName range:(NSRange)range size:(CGSize)size;
- (void)sc_setImageWithName:(NSString *)imageName range:(NSRange)range font: (UIFont *)font;
- (void)sc_insertImageWithName:(NSString *)imageName location:(NSUInteger)location bounds:(CGRect)bounds;

// attributedString -> size
- (CGSize)sizeForMaxWidth:(CGFloat)width;
// attributedString appendString
- (void)appendString:(NSString *)string;

@end
