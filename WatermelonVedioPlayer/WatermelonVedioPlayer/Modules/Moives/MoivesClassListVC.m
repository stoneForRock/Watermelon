//
//  MoivesClassListVC.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MoivesClassListVC.h"
#import "MoviesClassListCell1.h"
#import "MoviesClassListCell2.h"
#import "HUDHelper.h"
#import "MoivesModel.h"
#import <MJRefresh/MJRefresh.h>

#define MoviesClassListCell1Identifier  @"MoviesClassListCell1"
#define MoviesClassListCell2Identifier  @"MoviesClassListCell2"

@interface MoivesClassListVC ()<UITableViewDelegate, UITableViewDataSource, FilterSortViewDelegate, FilterSortViewDataSource>

@property (strong, nonatomic) FilterSortView *filterSortView;
@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@property (nonatomic, strong) NSMutableArray *tableList;
@property (nonatomic, assign) int currentPage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableTopConstraint;

@end

@implementation MoivesClassListVC
INSTANCE_XIB_M(@"Moives", MoivesClassListVC)
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    
    [self initUI];
    
    [self requestData];
}

- (void)initDataInfo {
    self.currentPage = 1;
    self.tableList = [NSMutableArray arrayWithCapacity:0];
}

- (void)initUI {
    self.title = self.navTitle?self.navTitle:@"全部高清影片";
    self.filterSortView = [[FilterSortView alloc] initWithFilterType:self.topViewType frame:CGRectMake(0, SafeTopHeight, self.view.frame.size.width, (self.topViewType == FilterSort)?80:40) delegate:self dataSource:self];
    [self.view addSubview:self.filterSortView];
    
    self.tabelView.tableFooterView = [[UIView alloc] init];
    
    if (self.topViewType == FilterSort) {
        self.tableTopConstraint.constant = 80;
    } else {
        self.tableTopConstraint.constant = 40;
    }
    
    [self registTableCell];
}

- (void)registTableCell {
    [self.tabelView registerNib:[UINib nibWithNibName:NSStringFromClass([MoviesClassListCell1 class]) bundle:nil] forCellReuseIdentifier:MoviesClassListCell1Identifier];
    [self.tabelView registerNib:[UINib nibWithNibName:NSStringFromClass([MoviesClassListCell2 class]) bundle:nil] forCellReuseIdentifier:MoviesClassListCell2Identifier];
}

- (void)requestData {
    [HUDHelper showHUDLoading:self.view text:@"请稍候..."];
    [MoivesRequest requestMovieListWithSortType:self.sortType classId:self.classId page:[NSString stringWithFormat:@"%d",self.currentPage] finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        [HUDHelper hideHUDView:self.view];
        [self.tabelView.mj_footer endRefreshing];
        if (success) {
            int pageNum = [responseObject[@"pageNum"] intValue];
            if (pageNum == 1) {
                [self.tableList removeAllObjects];
            }
            NSArray *pageData = responseObject[@"data"];
            int pageSize = [responseObject[@"pageSize"] intValue];
            if (pageSize == pageData.count) {
                self.tabelView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.currentPage = self.currentPage+1;
                    [self requestData];
                }];
            } else {
                self.tabelView.mj_footer = nil;
            }
            
            if (self.listType == MoivesList1Type) {
                [self formartStyleCell1Data:responseObject[@"data"]];
            } else if (self.listType == MoivesList2Type) {
                [self formartStyleCell2Data:responseObject[@"data"]];
            }
        } else {
            [HUDHelper showHUDText:error.domain duration:1.5];
        }
    }];
}

- (void)formartStyleCell1Data:(NSArray *)data {
    for (NSDictionary *movieDic in data) {
        MoivesModel *model = [[MoivesModel alloc] initWithDictionary:movieDic error:nil];
        if (model) {
            [self.tableList addObject:model];
        }
    }
    [self.tabelView reloadData];
    if (self.tableList.count > 0) {
        [self.tabelView hideNoDataView];
    } else {
        [self.tabelView showNoDataView:@"暂无该系列影片"];
    }
}

- (void)formartStyleCell2Data:(NSArray *)data {
    for (int i = 0; i < data.count; i ++) {
        NSDictionary *movieDic = data[i];
        MoivesModel *model = [[MoivesModel alloc] initWithDictionary:movieDic error:nil];
        if (model) {
            if ((i+1)%2 == 1) {
                [self.tableList addObject:[NSArray arrayWithObject:model]];
            } else {
                NSMutableArray *lastArray = [NSMutableArray arrayWithArray:[self.tableList lastObject]];
                [lastArray addObject:model];
                [self.tableList removeLastObject];
                [self.tableList addObject:lastArray.copy];
            }
        }
    }
    [self.tabelView reloadData];
    if (self.tableList.count > 0) {
        [self.tabelView hideNoDataView];
    } else {
        [self.tabelView showNoDataView:@"暂无该系列影片"];
    }
}

#pragma mark - FilterSortViewDelegate

- (void)filterSortDidChangeWithSortData:(NSDictionary *)sortData filterData:(NSDictionary *)filterData {
    self.sortType = [sortData[@"sortIndex"] integerValue];
    self.classId = filterData[@"id"];
    self.currentPage = 1;
    [self requestData];
}

- (NSInteger)defaultSortIndex {
    return self.sortType;
}

- (NSInteger)defaultFilterIndex {
    NSPredicate *classPre = [NSPredicate predicateWithFormat:@"self.id = %@",self.classId];
    NSArray *filterArray = [self.allClassList filteredArrayUsingPredicate:classPre];
    if (filterArray.count > 0) {
        NSDictionary *filterDic = [filterArray lastObject];
        return [self.allClassList indexOfObject:filterDic];
    } else {
        return 0;
    }
}

- (NSArray<NSDictionary *> *)filterDataSource {
    return self.allClassList;
}

- (NSArray<NSDictionary *> *)sortDataSource {
    return @[@{@"sortName":@"综合",@"sortId":@"",@"sortIndex":@"0"},@{@"sortName":@"最多播放",@"sortId":@"play_count",@"sortIndex":@"1"},@{@"sortName":@"最近更新",@"sortId":@"id",@"sortIndex":@"2"},@{@"sortName":@"最多喜欢",@"sortId":@"love_cnt",@"sortIndex":@"3"}];
}

#pragma mark - tableDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listType == MoivesList1Type) {
        MoviesClassListCell1 *cell = [tableView dequeueReusableCellWithIdentifier:MoviesClassListCell1Identifier];
        MoivesModel *cellModel = self.tableList[indexPath.row];
        cell.movieModel = cellModel;
        return cell;
    } else if (self.listType == MoivesList2Type) {
        MoviesClassListCell2 *cell = [tableView dequeueReusableCellWithIdentifier:MoviesClassListCell2Identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *cellList = self.tableList[indexPath.row];
        cell.cellList = cellList;
        return cell;
    } else {
        return nil;
    }
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.listType == MoivesList1Type) {
        MoivesModel *cellModel = self.tableList[indexPath.row];
        
    }
}


@end
