//
//  UIView+NoData.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/27.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "UIView+NoData.h"
#import "NoDataView.h"

@implementation UIView (NoData)

#define kNoDataViewTag 120

- (void)showNoDataView:(NSString *)text
{
    NoDataView *noDataView = [self viewWithTag:kNoDataViewTag];
    if (!noDataView) {
        noDataView = [[[UINib nibWithNibName:@"NoDataView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        noDataView.frame = CGRectMake((self.frame.size.width-240)/2, (self.frame.size.height-240)/2, 240, 240);
        [self addSubview:noDataView];
        noDataView.tag = kNoDataViewTag;
    }
    if (text) {
        noDataView.alertTextLabel.text = text;
    }
    noDataView.hidden = NO;
}

- (void)showNoDataView:(NSString *)text offsetY:(CGFloat)y
{
    NoDataView *noDataView = [self viewWithTag:kNoDataViewTag];
    if (!noDataView) {
        noDataView = [[[UINib nibWithNibName:@"NoDataView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        noDataView.frame = CGRectMake((self.frame.size.width-240)/2, (self.frame.size.height-240)/2 + y, 240, 240);
        [self addSubview:noDataView];
        noDataView.tag = kNoDataViewTag;
    }
    if (text) {
        noDataView.alertTextLabel.text = text;
    }
    noDataView.hidden = NO;
}

- (void)hideNoDataView
{
    NoDataView *noDataView = [self viewWithTag:kNoDataViewTag];
    if (noDataView) {
        noDataView.hidden = YES;
    }
}


@end
