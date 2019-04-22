//
//  ColumnAdCell.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/22.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "ColumnAdCell.h"
#import "RollingCircleScroll.h"

@interface ColumnAdCell ()<RollingCircleScrollDelegate>

@property (weak, nonatomic) IBOutlet UIView *scrollBgView;
@property (nonatomic, strong) RollingCircleScroll *circleScroll;

@end

@implementation ColumnAdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setAdInfos:(NSArray *)adInfos {
    _adInfos = adInfos;
    [self initTopScrollWithData:adInfos];
}

- (void)initTopScrollWithData:(NSArray *)ads {
    if (self.circleScroll) {
        [self.circleScroll removeFromSuperview];
        self.circleScroll = nil;
    }
    self.circleScroll = [[RollingCircleScroll alloc] initWithFrame:CGRectMake(0, 0, self.scrollBgView.frame.size.width, 165) withDataSources:ads];
    self.circleScroll.delegate = self;
    [self.scrollBgView addSubview:self.circleScroll];
}

//点击滚动广告
- (void)rollingCircleScrollClickPage:(id)pageInfo {
    NSString *linkAddr = pageInfo[@"linkAddr"]?:@"";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkAddr] options:@{} completionHandler:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
