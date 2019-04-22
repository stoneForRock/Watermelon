//
//  SpecialCardView.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/19.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "SpecialCardView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SpecialCardView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end

@implementation SpecialCardView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconImageView.layer.cornerRadius = 6.0;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderWidth = 3.0;
    self.iconImageView.layer.borderColor = ThemeColor.CGColor;
}

- (void)setColumnSubObj:(NSDictionary *)columnSubObj {
    _columnSubObj = columnSubObj;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:columnSubObj[@"navImage"]]];
    self.nameLabel.text = columnSubObj[@"navName"]?columnSubObj[@"navName"]:@"";
    self.dateLabel.text = columnSubObj[@"lastUpdateTime"]?columnSubObj[@"lastUpdateTime"]:@"";
    self.desLabel.text = columnSubObj[@"intro"]?columnSubObj[@"intro"]:@"";
}

- (IBAction)clickDetailAction:(UIButton *)sender {
    if (self.specialCardViewDelegate != nil && [self.specialCardViewDelegate respondsToSelector:@selector(clickSpecialCard:)]) {
        [self.specialCardViewDelegate clickSpecialCard:self.columnSubObj];
    }
}

@end
