//
//  ChannelVC.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "ChannelVC.h"
#import "SegmentView.h"
#import "RecommendColumnVC.h"
#import "TagFilterVC.h"

@interface ChannelVC ()<SegmentViewDelegate>

@property (nonatomic, strong) UIView *navBarView;
@property (nonatomic, strong) SegmentView *segmentView;
@property (nonatomic, strong) RecommendColumnVC *columnVC;
@property (nonatomic, strong) TagFilterVC *tagVC;

@end

@implementation ChannelVC

INSTANCE_XIB_M(@"Channel", ChannelVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    [self initUI];
    [self requestChannelInfo];
}

- (void)initUI {
    [self initNavBarView];
    [self initSubController];
}

- (void)initSubController {
    
    self.tagVC = [TagFilterVC instanceFromXib];
    [self addChildViewController:self.tagVC];
    [self.view addSubview:self.tagVC.view];
    
    self.columnVC = [RecommendColumnVC instanceFromXib];
    [self addChildViewController:self.columnVC];
    [self.view addSubview:self.columnVC.view];
}

- (void)initNavBarView {
    self.navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenFullWidth - 30, 44)];
    self.navigationItem.titleView = self.navBarView;
    
    self.segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(20, 0, ScreenFullWidth - 70, 44)];
    self.segmentView.delegate = self;
    [self.segmentView setSegmentTitles:@[@"专栏推荐",@"标签筛选"]];
    [self.navBarView addSubview:self.segmentView];
}

- (void)initDataInfo {
    
}

- (void)requestChannelInfo {
    
}

#pragma mark - SegmentViewDelegate

- (void)segmentView:(SegmentView *)segmentView didSelectIndex:(NSUInteger)index {
    self.columnVC.view.hidden = (index != 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
