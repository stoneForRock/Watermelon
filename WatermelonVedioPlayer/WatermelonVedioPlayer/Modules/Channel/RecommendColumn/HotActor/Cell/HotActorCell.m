//
//  HotActorCell.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/23.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "HotActorCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HotActorCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) CAGradientLayer *gradient;
@end

@implementation HotActorCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.layer.cornerRadius = 40.0;
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
    
    self.iconImageView.frame = CGRectMake((self.frame.size.width - 80)/2, 20, 80, 80);
    self.nameLabel.frame = CGRectMake(0, 110, self.frame.size.width, 30);
}

- (void)setCellInfo:(NSDictionary *)cellInfo {
    [self.gradient removeFromSuperlayer];
    self.gradient = nil;
    _cellInfo = cellInfo;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:cellInfo[@"photoUrl"]?cellInfo[@"photoUrl"]:@""]];
    self.nameLabel.text = cellInfo[@"nameCn"]?cellInfo[@"nameCn"]:@"";
    
    self.gradient = [CAGradientLayer layer];
    self.gradient.frame = self.bounds;
    self.gradient.colors = @[(id)[self.bgColor colorWithAlphaComponent:0.8].CGColor,(id)[self.bgColor colorWithAlphaComponent:0.2].CGColor];
    self.gradient.startPoint = CGPointMake(0, 0);
    self.gradient.endPoint = CGPointMake(1, 1);
    [self.layer insertSublayer:self.gradient atIndex:0];
}

@end
