//
//  PlayHistoryVC.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/8.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "PlayHistoryVC.h"
#import "PlayHistoryManager.h"
#import "MoivesModel.h"
#import "MoviesClassListCell1.h"
#import "MoivesDetialVC.h"

#define MoviesClassListCell1Identifier  @"MoviesClassListCell1"

@interface PlayHistoryVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *tableList;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PlayHistoryVC

INSTANCE_XIB_M(@"MainPage", PlayHistoryVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    [self initUI];
}

- (void)initUI {
    self.title = @"观影记录";
    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeTopHeight, ScreenFullWidth, self.view.frame.size.height)];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MoviesClassListCell1 class]) bundle:nil] forCellReuseIdentifier:MoviesClassListCell1Identifier];
}

- (void)initDataInfo {
    self.tableList = [NSMutableArray arrayWithArray:[[PlayHistoryManager shared] readMovies]];
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoviesClassListCell1 *cell = [tableView dequeueReusableCellWithIdentifier:MoviesClassListCell1Identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MoivesModel *cellModel = self.tableList[indexPath.row];
    MoivesDetialVC *moivesDetialVC = [MoivesDetialVC instanceFromXib];
    moivesDetialVC.movieModel = cellModel;
    moivesDetialVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moivesDetialVC animated:YES];
}

@end
