//
//  ChannelVC.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "ChannelVC.h"

@interface ChannelVC ()

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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [button sizeToFit];
    button.frame = CGRectMake(0, 0, 21, 21);
    [button addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)initDataInfo {
    
}

- (void)requestChannelInfo {
    
}

//搜索
- (void)searchAction:(UIButton *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
