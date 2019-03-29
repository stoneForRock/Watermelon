//
//  MoivesDetialVC.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MoivesDetialVC.h"
#import "HUDHelper.h"
#import "MovieLiveView.h"

@interface MoivesDetialVC ()

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *movieTitleLabel;
@property (nonatomic, strong) MovieLiveView *liveView;

@end

@implementation MoivesDetialVC

INSTANCE_XIB_M(@"Moives", MoivesDetialVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    [self initUI];
    [self requestData];
}

- (void)initUI {
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.movieTitleLabel];
    
    self.backBtn.frame = CGRectMake(20, 20, 26, 44);
    self.movieTitleLabel.frame = CGRectMake(CGRectGetMaxX(self.backBtn.frame) + 10, 20, 200, 44);
    
}

- (void)initDataInfo {
    self.movieTitleLabel.text = self.movieModel.movName;
}

- (void)requestData {
    
}

#pragma mark - btnAction

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - lazyLoad

- (UIButton *)backBtn {
    if (!_backBtn) {
        UIImage *image = [UIImage imageNamed:@"nav_back"];
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:image forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UILabel *)movieTitleLabel {
    if (!_movieTitleLabel) {
        _movieTitleLabel = [[UILabel alloc] init];
        _movieTitleLabel.font = [UIFont systemFontOfSize:15];
        _movieTitleLabel.textColor = COLORWITHRGBADIVIDE255(194, 154, 104, 1);
    }
    return _movieTitleLabel;
}

@end
