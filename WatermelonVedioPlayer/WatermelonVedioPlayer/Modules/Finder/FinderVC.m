//
//  FinderVC.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "FinderVC.h"
#import "FinderCell.h"
#import "FinderRequest.h"
#import <MJRefresh/MJRefresh.h>
#import "HUDHelper.h"
#import "MoivesDetialVC.h"

#define FinderCellIdentifier @"FinderCell"

@interface FinderVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableList;

@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation FinderVC

INSTANCE_XIB_M(@"Finder", FinderVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    [self initUI];
    [self requestFinderList];
}

- (void)initUI {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FinderCell class]) bundle:nil] forCellReuseIdentifier:FinderCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)initDataInfo {
    self.tableList = [NSMutableArray arrayWithCapacity:0];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        [self requestFinderList];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestFinderList];
    }];
}

- (void)requestFinderList {
    [HUDHelper showHUDLoading:self.view text:@"请稍候..."];
    [FinderRequest requestDiscoverListWithPage:self.currentPage finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        [HUDHelper hideHUDView:self.view];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (success) {
            if (!self.currentPage) {
                [self.tableList removeAllObjects];
            }
            NSInteger pageSize = [responseObject[@"pageSize"] integerValue];
            NSArray *dataList = responseObject[@"data"]?responseObject[@"data"]:@[];
            if (dataList.count < pageSize) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            NSInteger pageNum = [responseObject[@"pageNum"] integerValue];
            self.currentPage = pageNum + 1;
            for (NSDictionary *movieDic in dataList) {
                MoivesModel *movieModel = [[MoivesModel alloc] initWithDictionary:movieDic error:nil];
                [self.tableList addObject:movieModel];
            }
            [self.tableView reloadData];
            if (self.tableList.count == 0) {
                [self.tableView showNoDataView:@"未找到发现视频"];
            } else {
                [self.tableView hideNoDataView];
            }
        } else {
            [HUDHelper showHUDWithErrorText:error.domain inView:self.view];
        }
    }];
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FinderCell *cell = [tableView dequeueReusableCellWithIdentifier:FinderCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MoivesModel *cellModel = self.tableList[indexPath.row];
    cell.movieModel = cellModel;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MoivesModel *cellModel = self.tableList[indexPath.row];
    MoivesDetialVC *moivesDetialVC = [MoivesDetialVC instanceFromXib];
    moivesDetialVC.movieModel = cellModel;
    moivesDetialVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moivesDetialVC animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
