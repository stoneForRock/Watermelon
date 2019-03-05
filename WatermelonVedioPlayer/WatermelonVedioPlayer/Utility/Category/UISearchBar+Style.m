//
//  UISearchBar+Style.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "UISearchBar+Style.h"

@implementation UISearchBar (Style)

- (void)setCustomPlaceholder:(NSString *)placeholder {
    if (!placeholder || placeholder.length == 0) {
        placeholder = @"搜索";
    }
    [[UITextField appearanceWhenContainedIn:[self class], nil] setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11], NSForegroundColorAttributeName : ThemeColor}]];
}

@end
