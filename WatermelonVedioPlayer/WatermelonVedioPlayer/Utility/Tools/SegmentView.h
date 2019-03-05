//
//  SegmentView.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SegmentView;
@protocol SegmentViewDelegate <NSObject>
- (void)segmentView:(SegmentView *)segmentView didSelectIndex:(NSUInteger)index;
@end


@interface SegmentView : UIView

@property (nonatomic) NSUInteger selectedIndex;
@property (nonatomic, strong) NSArray <NSString *>* titles;
@property (nonatomic) BOOL hasShadow;

@property (weak, nonatomic) IBOutlet id<SegmentViewDelegate> delegate;

- (void)setSegmentTitles:(NSArray <NSString *>*)titles; // init
- (void)setSegmentSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setSegmentSelectedIndexNoDelegate:(NSUInteger)index animated:(BOOL)animated;

@end
