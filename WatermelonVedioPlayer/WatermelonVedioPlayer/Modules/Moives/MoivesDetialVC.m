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
#import "MoivesRequest.h"
#import "MainPageRequest.h"

@interface MoivesDetialVC ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *movieTitleLabel;
@property (nonatomic, strong) MovieLiveView *liveView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableList;

@end

@implementation MoivesDetialVC

INSTANCE_XIB_M(@"Moives", MoivesDetialVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    [self initUI];
    [self requestData];
}

- (void)dealloc {
    self.navigationController.delegate = nil;
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)initUI {
    self.navigationController.delegate = self;
    
    self.liveView = [[MovieLiveView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.56)];
    [self.view addSubview:self.liveView];
    
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.movieTitleLabel];
    
    self.backBtn.frame = CGRectMake(10, 0, 26, 44);
    self.movieTitleLabel.frame = CGRectMake(CGRectGetMaxX(self.backBtn.frame) + 10, 0, 200, 44);
}

- (void)initDataInfo {
    self.movieTitleLabel.text = self.movieModel.movName;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlViewShow:) name:PlayerControlViewShow object:nil];
}

- (void)requestData {
    [self getMovieDetailRequest];
}

- (void)controlViewShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    BOOL show = [userInfo[@"show"] boolValue];
    if (show) {
        self.movieTitleLabel.hidden = NO;
        self.backBtn.hidden = NO;
    } else {
        self.movieTitleLabel.hidden = YES;
        self.backBtn.hidden = YES;
    }
}

//更新页面信息
- (void)refreshSelfViewWithMovieModel:(MoivesModel *)movieModel {
    
}

- (void)requestBeforPlayAdInfo {
    [MainPageRequest getADListWithType:ADListPrePlayType finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            if ([responseObject isKindOfClass:[NSArray class]]) {
                NSArray *allAdList = (NSArray *)responseObject;
                if (allAdList.count > 0) {
                    NSDictionary *adInfo = allAdList[0];
                    self.liveView.adInfo = adInfo;
                } else {
                    [self.liveView failLoadAdInfo];
                }
            } else {
                [self.liveView failLoadAdInfo];
            }
        } else {
            [self.liveView failLoadAdInfo];
        }
    }];
}

//获取影片详情信息
- (void)getMovieDetailRequest {
    [HUDHelper showHUDLoading:self.view text:@"请稍候..."];
    [MoivesRequest requestMovieDetailWithMovieId:self.movieModel.moiveId finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        [HUDHelper hideHUDView:self.view];
        if (success) {
            MoivesModel *model = [[MoivesModel alloc] initWithDictionary:responseObject error:nil];
            if (model) {
                self.movieModel = model;
            }
            self.liveView.movieModel = self.movieModel;
            [self refreshSelfViewWithMovieModel:self.movieModel];
            [self requestBeforPlayAdInfo];
            [self movieAlikeListRequest];
        } else {
            [HUDHelper showHUDText:error.domain duration:1.5 inView:self.view];
        }
    }];
}

//获取关联相似影片
- (void)movieAlikeListRequest {
    [MoivesRequest getMovieAlikeListWithId:self.movieModel.moiveId finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
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
