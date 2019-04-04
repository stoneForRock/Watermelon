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
#import "MovieDetailInfoView.h"
#import "MoviesClassListCell1.h"
#import "MovieIntroduceView.h"

#define MoviesClassListCell1Identifier  @"MoviesClassListCell1"

@interface MoivesDetialVC ()<UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource,MovieDetailInfoViewDelegate>

@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *movieTitleLabel;
@property (nonatomic, strong) MovieLiveView *liveView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableList;

@property (nonatomic, strong) MovieDetailInfoView *infoView;
@property (nonatomic, strong) MovieIntroduceView *introduceView;
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
    [self.liveView resetPlayer];
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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.liveView.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.liveView.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MoviesClassListCell1 class]) bundle:nil] forCellReuseIdentifier:MoviesClassListCell1Identifier];
    
    self.infoView = [[MovieDetailInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.liveView.frame), [UIScreen mainScreen].bounds.size.width, 350.5)];
    self.infoView.infoViewDelegate = self;
    self.tableView.tableHeaderView = self.infoView;
}

- (void)initDataInfo {
    self.movieTitleLabel.text = self.movieModel.movName;
    self.tableList = [NSMutableArray arrayWithCapacity:0];
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

- (void)requestDetailAdInfo {
    [MainPageRequest getADListWithType:ADListVideoDetialType finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            if ([responseObject isKindOfClass:[NSArray class]]) {
                NSArray *allAdList = (NSArray *)responseObject;
                if (allAdList.count > 0) {
                    NSDictionary *adInfo = allAdList[0];
                    self.infoView.adInfo = adInfo;
                } else {
                    [self.infoView failLoadAdInfo];
                }
            } else {
                [self.infoView failLoadAdInfo];
            }
        } else {
            [self.infoView failLoadAdInfo];
        }
    }];
}

//获取影片详情信息
- (void)getMovieDetailRequest {
    [HUDHelper showHUDLoading:self.view text:@"请稍候..."];
    [MoivesRequest requestMovieDetailWithMovieId:self.movieModel.moiveId finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        [HUDHelper hideHUDView:self.view];
        if (success) {
            MoivesModel *model = [[MoivesModel alloc] initWithDetailDictionary:responseObject];
            if (model) {
                self.movieModel = model;
            }
            self.liveView.movieModel = self.movieModel;
            self.infoView.infoModel = self.movieModel;
            [self requestBeforPlayAdInfo];
            [self requestDetailAdInfo];
            [self movieAlikeListRequest];
        } else {
            [HUDHelper showHUDText:error.domain duration:1.5 inView:self.view];
        }
    }];
}

//获取关联相似影片
- (void)movieAlikeListRequest {
    [MoivesRequest getMovieAlikeListWithId:self.movieModel.moiveId finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        [self.tableList removeAllObjects];
        if (success) {
            for (NSDictionary *movieDic in responseObject) {
                MoivesModel *model = [[MoivesModel alloc] initWithDictionary:movieDic error:nil];
                if (model) {
                    [self.tableList addObject:model];
                }
            }
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - MovieDetailInfoViewDelegate
- (void)showIntroduceMovie:(MoivesModel *)movie {
    [MovieIntroduceView showIntroduceViewWithMovie:movie rect:CGRectMake(0, CGRectGetMaxY(self.liveView.frame), self.view.frame.size.width, self.tableView.frame.size.height) inView:self.view];}

- (void)dwonLoadMovie:(MoivesModel *)movie {
    
}

- (void)shareMovie:(MoivesModel *)movie {
    
}

#pragma mark - tableDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoviesClassListCell1 *cell = [tableView dequeueReusableCellWithIdentifier:MoviesClassListCell1Identifier];
    MoivesModel *cellModel = self.tableList[indexPath.row];
    cell.movieModel = cellModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MoivesModel *cellModel = self.tableList[indexPath.row];
    
    MoivesDetialVC *moivesDetialVC = [MoivesDetialVC instanceFromXib];
    moivesDetialVC.movieModel = cellModel;
    moivesDetialVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moivesDetialVC animated:YES];
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
