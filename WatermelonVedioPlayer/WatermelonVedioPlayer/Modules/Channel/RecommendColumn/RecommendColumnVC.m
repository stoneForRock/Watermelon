//
//  RecommendColumnVC.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/4/13.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "RecommendColumnVC.h"
#import "ChannelRequest.h"
#import "MainPageRequest.h"
#import "RollingCircleScroll.h"

@interface RecommendColumnVC ()<RollingCircleScrollDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableList;
@property (nonatomic, strong) RollingCircleScroll *circleScroll;

@end

@implementation RecommendColumnVC
INSTANCE_XIB_M(@"Channel", RecommendColumnVC)
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    [self initUI];
    [self requestColumnInfo];
}

- (void)initUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenFullWidth, ScreenFullHeight - NavigationBarHeight - StatusBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)initTopScrollWithData:(NSArray *)ads {
    if (self.circleScroll) {
        [self.circleScroll removeFromSuperview];
        self.circleScroll = nil;
    }
    self.circleScroll = [[RollingCircleScroll alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) withDataSources:ads];
    self.circleScroll.delegate = self;
    [self.tableView.tableHeaderView addSubview:self.circleScroll];
}

- (void)initDataInfo {
    self.tableList = [NSMutableArray arrayWithCapacity:0];
}

- (void)requestColumnInfo {
    [self requestTopAdInfo];
    [self requestActoryCategory];
    [self requestHotsActor];
}

- (void)requestActoryCategory {
    [ChannelRequest getActorCategoriesFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
}

- (void)requestHotsActor {
    [ChannelRequest getHotsActorFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
}

- (void)requestTopAdInfo {
    [MainPageRequest getADListWithType:ADListChannelType finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            [self initTopScrollWithData:responseObject];
        }
    }];
}

//点击滚动广告
- (void)rollingCircleScrollClickPage:(id)pageInfo {
    NSString *linkAddr = pageInfo[@"linkAddr"]?:@"";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkAddr] options:@{} completionHandler:nil];
}

@end
