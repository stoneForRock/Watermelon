//
//  MainPageVC.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "MainPageVC.h"
#import "MainSearchVC.h"
#import "PlayHistoryVC.h"

@interface MainPageVC ()

@property (nonatomic, strong) UIView *navBarView;

@end

@implementation MainPageVC

INSTANCE_XIB_M(@"MainPage", MainPageVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBarView];
}

- (void)initNavBarView {
    self.navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenFullWidth - 30, 44)];
    self.navigationItem.titleView = self.navBarView;
    
    UIView *searchBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, CGRectGetWidth(self.navBarView.frame) - 120, 34)];
    searchBgView.backgroundColor = COLORWITHRGBADIVIDE255(30, 30, 30, 1.0);
    searchBgView.layer.cornerRadius = 17.0;
    searchBgView.layer.masksToBounds = YES;
    [self.navBarView addSubview:searchBgView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction)];
    [searchBgView addGestureRecognizer:tapGesture];
    
    UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(searchBgView.frame), 34)];
    searchLabel.textColor = COLORWITHRGBADIVIDE255(151, 151, 151, 1.0);
    searchLabel.text = @"输入关键词查找片源";
    searchLabel.textAlignment = NSTextAlignmentCenter;
    searchLabel.font = [UIFont systemFontOfSize:14];
    [searchBgView addSubview:searchLabel];
    
    UIImageView *searchImgView = [[UIImageView alloc] initWithFrame:CGRectMake( 20, 6.5, 21, 21)];
    searchImgView.image = [UIImage imageNamed:@"search"];
    [searchBgView addSubview:searchImgView];
    
    UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [historyBtn setImage:[UIImage imageNamed:@"history"] forState:UIControlStateNormal];
    historyBtn.frame = CGRectMake(CGRectGetWidth(self.navBarView.frame) - 34, 5, 34, 34);
    [historyBtn addTarget:self action:@selector(pushToHistoryList) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView addSubview:historyBtn];
    
    UIButton *downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [downloadBtn setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    downloadBtn.frame = CGRectMake(CGRectGetMinX(historyBtn.frame) - 5 - 34, 5, 34, 34);
    [downloadBtn addTarget:self action:@selector(pushToDownloadList) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView addSubview:downloadBtn];
    
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanBtn setImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    scanBtn.frame = CGRectMake(CGRectGetMinX(downloadBtn.frame) - 5 - 34, 5, 34, 34);
    [scanBtn addTarget:self action:@selector(pushToScanList) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView addSubview:scanBtn];
}

#pragma mark - btnAction

//搜索
- (void)searchAction {
    MainSearchVC *searchVC = [MainSearchVC instanceFromXib];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}

//扫码
- (void)pushToScanList {
    
}

//下载
- (void)pushToDownloadList {
    
}

//历史记录
- (void)pushToHistoryList {
    PlayHistoryVC *historyVC = [PlayHistoryVC instanceFromXib];
    historyVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:historyVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
