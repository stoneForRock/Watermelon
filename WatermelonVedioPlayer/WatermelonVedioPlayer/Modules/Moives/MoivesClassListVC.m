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
#import "MoviesClassListCell3.h"
#import "HUDHelper.h"

#define MoviesClassListCell1Identifier  @"MoviesClassListCell1"
#define MoviesClassListCell2Identifier  @"MoviesClassListCell2"
#define MoviesClassListCell3Identifier  @"MoviesClassListCell3"

@interface MoivesClassListVC ()<UITableViewDelegate, UITableViewDataSource, FilterSortViewDelegate, FilterSortViewDataSource>

@property (strong, nonatomic) FilterSortView *filterSortView;
@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@property (nonatomic, strong) NSMutableArray *tableList;
@property (nonatomic, assign) int currentPage;

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
    self.filterSortView = [[FilterSortView alloc] initWithFilterType:self.topViewType frame:CGRectMake(0, SafeTopHeight, self.view.frame.size.width, 80) delegate:self dataSource:self];
    [self.view addSubview:self.filterSortView];
    
    [self registTableCell];
}

- (void)registTableCell {
    [self.tabelView registerNib:[UINib nibWithNibName:NSStringFromClass([MoviesClassListCell1 class]) bundle:nil] forCellReuseIdentifier:MoviesClassListCell1Identifier];
    [self.tabelView registerNib:[UINib nibWithNibName:NSStringFromClass([MoviesClassListCell2 class]) bundle:nil] forCellReuseIdentifier:MoviesClassListCell2Identifier];
    [self.tabelView registerNib:[UINib nibWithNibName:NSStringFromClass([MoviesClassListCell3 class]) bundle:nil] forCellReuseIdentifier:MoviesClassListCell3Identifier];
}

- (void)requestData {
    [HUDHelper showHUDLoading:self.view text:@"请稍候..."];
    [MoivesRequest requestMovieListWithSortType:self.sortType classId:self.classId page:[NSString stringWithFormat:@"%d",self.currentPage] finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        [HUDHelper hideHUDView:self.view];
        if (success) {
             
        } else {
            [HUDHelper showHUDText:error.domain duration:1.5];
        }
    }];
}

#pragma mark - FilterSortViewDelegate

- (void)filterSortDidChangeWithSortData:(NSDictionary *)sortData filterData:(NSDictionary *)filterData {
    
}

- (NSArray<NSDictionary *> *)filterDataSource {
    return @[@{},@{},@{}];
}

- (NSArray<NSDictionary *> *)sortDataSource {
    return @[@{},@{},@{}];
}

#pragma mark - tableDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MoviesClassListCell1Identifier];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
