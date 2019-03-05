//
//  NSMutableAttributedString+Style.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "NSMutableAttributedString+Style.h"
#import "NSString+Tool.h"
#import <CoreText/CoreText.h>

@implementation NSMutableAttributedString (Style)

- (void)sc_setFont:(UIFont *)font
{
    [self sc_setFont:font range:NSMakeRange(0, self.string.length)];
}

- (void)sc_setFont:(UIFont *)font range:(NSRange)range
{
    [self addAttributes:@{NSFontAttributeName: font} range:range];
}

- (void)sc_setTextColor:(UIColor *)color
{
    [self sc_setTextColor:color range:NSMakeRange(0, self.string.length)];
}

- (void)sc_setTextColor:(UIColor *)color range:(NSRange)range
{
    [self addAttributes:@{NSForegroundColorAttributeName: color} range:range];
}

- (void)sc_setTextColor:(UIColor *)color keyword:(NSString *)keyword
{
    NSArray *arrayRanges = [self.string sc_rangesOfString:keyword];
    for (NSValue *valueRange in arrayRanges) {
        NSRange range = [valueRange rangeValue];
        [self sc_setTextColor:color range:range];
    }
}

- (void)sc_setTextAlignment:(NSTextAlignment)alignment
{
    [self sc_setTextAlignment:alignment range:NSMakeRange(0, self.string.length)];
}

- (void)sc_setTextAlignment:(NSTextAlignment)alignment range:(NSRange)range
{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:alignment];
    [self addAttributes:@{NSParagraphStyleAttributeName: style} range:range];
}

- (void)sc_setUnderline
{
    [self sc_setUnderlineWithRange:NSMakeRange(0, self.string.length)];
}

- (void)sc_setUnderlineWithRange:(NSRange)range
{
    [self addAttributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)} range:range];
}


+ (NSDictionary *)sc_linkAttributeWithLinkColor: (UIColor *)color
{
    return @{NSForegroundColorAttributeName: color};
}

- (void)sc_setLinkWithRange:(NSRange)range URL:(NSURL *)URL
{
    [self addAttributes:@{NSLinkAttributeName: URL} range:range];
}

- (void)sc_setParagraphStyle:(NSParagraphStyle *)style
{
    [self sc_setParagraphStyle:style range:NSMakeRange(0, self.string.length)];
}

- (void)sc_setParagraphStyle:(NSParagraphStyle *)style range:(NSRange)range
{
    [self addAttributes:@{NSParagraphStyleAttributeName: style} range:range];
}

// NSBaselineOffsetAttributeName
- (void)sc_setBaselineOffset:(CGFloat)fOffset
{
    [self sc_setBaselineOffset:fOffset range:NSMakeRange(0, self.string.length)];
}

- (void)sc_setBaselineOffset:(CGFloat)fOffset range:(NSRange)range
{
    [self addAttributes:@{NSBaselineOffsetAttributeName: @(fOffset)} range:range];
}

// letter spacing
- (void)sc_setLineSpacing:(CGFloat)fSpacing
{
    [self sc_setLineSpacing:fSpacing range: NSMakeRange(0, self.string.length)];
}

- (void)sc_setLineSpacing:(CGFloat)fSpacing range:(NSRange)range
{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setLineSpacing:fSpacing];
    [self sc_setParagraphStyle:style range:range];
}

- (void)sc_setLetterSpacing:(CGFloat)fSpacing
{
    [self sc_setLetterSpacing:fSpacing range:NSMakeRange(0, self.string.length)];
}

- (void)sc_setLetterSpacing:(CGFloat)fSpacing range:(NSRange)range
{
    [self addAttribute:NSKernAttributeName
                 value:@(fSpacing)
                 range:range];
}

- (void)sc_setImageWithName:(NSString *)imageName range:(NSRange)range
{
    [self sc_setImageWithName:imageName range:range size:CGSizeZero];
}

- (void)sc_setImageWithName:(NSString *)imageName range:(NSRange)range font: (UIFont *)font
{
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:imageName];
    textAttachment.bounds = CGRectMake(0, font.descender, font.lineHeight, font.lineHeight);
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [self replaceCharactersInRange:range withAttributedString:attrStringWithImage];
}

- (void)sc_insertImageWithName:(NSString *)imageName location:(NSUInteger)location bounds:(CGRect)bounds {
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:imageName];
    textAttachment.bounds = bounds;
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [self insertAttributedString:attrStringWithImage atIndex:location];
}



- (void)sc_setImageWithName:(NSString *)imageName range:(NSRange)range size:(CGSize)size
{
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:imageName];
    
    if (!CGSizeEqualToSize(size, CGSizeZero)) {
        textAttachment.bounds = CGRectMake(0,
                                           1,
                                           size.width,
                                           size.height);
    }
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [self replaceCharactersInRange:range withAttributedString:attrStringWithImage];
}

- (CGSize)sizeForMaxWidth:(CGFloat)width {
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

- (void)appendString:(NSString *)string
{
    if (string.length > 0) {
        NSUInteger selfLengthBefore = [self length];
        
        [self.mutableString appendString:string];
        
        NSRange appendedStringRange = NSMakeRange(selfLengthBefore, [string length]);
        
        // we need to remove the image placeholder (if any) to prevent duplication
        [self removeAttribute:NSAttachmentAttributeName range:appendedStringRange];
        [self removeAttribute:(id)kCTRunDelegateAttributeName range:appendedStringRange];
    }
}
@end
