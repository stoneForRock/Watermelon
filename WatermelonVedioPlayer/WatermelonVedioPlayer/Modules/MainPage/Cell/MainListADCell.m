//
//  MainListADCell.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/14.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MainListADCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MainListADCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *adNameLabel;

@end

@implementation MainListADCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setAdInfo:(NSDictionary *)adInfo {
    _adInfo = adInfo;
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:adInfo[@"thumbnail"]]];
    self.adNameLabel.text = adInfo[@"adName"]?adInfo[@"adName"]:@"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
