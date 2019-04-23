//
//  HotColumnCell.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/23.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "HotColumnCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HotColumnCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation HotColumnCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.layer.cornerRadius = 30.0;
        self.iconImageView.layer.masksToBounds = YES;
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.iconImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = COLORWITHRGBADIVIDE255(171, 171, 171, 1);
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.nameLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.frame = CGRectMake((self.frame.size.width - 60)/2, 20, 60, 60);
    self.nameLabel.frame = CGRectMake(0, 90, self.frame.size.width, 30);
}

- (void)setCellInfo:(NSDictionary *)cellInfo {
    _cellInfo = cellInfo;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:cellInfo[@"navImage"]?cellInfo[@"navImage"]:@""]];
    self.nameLabel.text = cellInfo[@"navName"]?cellInfo[@"navName"]:@"";
}

@end
