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
#import "ActorCategoriesCell.h"
#import "ActorTopicCell.h"
#import "ColumnNavsCell.h"
#import "ColumnAdCell.h"
#import <MJRefresh/MJRefresh.h>
#import "SpecialTopicMoiveListVC.h"
#import "MoivesDetialVC.h"
#import "HotColumnVC.h"
#import "HotActorVC.h"

#define ColumnNavsCellIdentifier @"ColumnNavsCell"
#define ColumnAdCellIdentifier @"ColumnAdCell"
#define ActorCategoriesCellIdentifier @"ActorCategoriesCell"
#define ActorTopicCellIdentifier @"ActorTopicCell"

@interface RecommendColumnVC ()<UITableViewDelegate, UITableViewDataSource, ActorCategoriesCellDelegate, ActorTopicCellDelegate, ColumnNavsCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableList;

@property (nonatomic, strong) NSMutableArray *hotColumnFilterArray;

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
    
    self.view.backgroundColor = COLORWITHRGBADIVIDE255(29, 29, 29, 1);
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenFullWidth, ScreenFullHeight - NavigationBarHeight - StatusBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = COLORWITHRGBADIVIDE255(29, 29, 29, 1);
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self regiserTableCell];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestColumnInfo];
    }];
}

- (void)regiserTableCell {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ColumnNavsCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ColumnNavsCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ColumnAdCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ColumnAdCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActorCategoriesCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ActorCategoriesCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActorTopicCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ActorTopicCellIdentifier];
}

- (void)initDataInfo {
    self.tableList = [NSMutableArray arrayWithObjects:@{},@[],@[],@[],nil];
    self.hotColumnFilterArray = [NSMutableArray arrayWithCapacity:0];
}

- (void)requestColumnInfo {
    [self requestTopAdInfo];
    [self requestColumnNavs];
    [self requestHotsActor];
    [self requestMoreColumnCategory];
}

- (void)requestColumnNavs {
    [ChannelRequest getColumnNavsFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        [self.tableView.mj_header endRefreshing];
        if (success) {
            NSArray *responseArray = responseObject;
            if (responseArray.count > 1) {
                NSArray *columnNav1 = responseObject[0];
                NSArray *columnNav2 = responseObject[1];
                [self.tableList replaceObjectAtIndex:0 withObject:columnNav1];
                [self.tableList replaceObjectAtIndex:2 withObject:columnNav2];
            }
            [self.tableView reloadData];
        }
    }];
}

- (void)requestHotsActor {
    [ChannelRequest getHotsActorFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            [self.tableList replaceObjectAtIndex:3 withObject:responseObject];
        }
        [self.tableView reloadData];
    }];
}

- (void)requestTopAdInfo {
    [MainPageRequest getADListWithType:ADListChannelType finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            [self.tableList replaceObjectAtIndex:1 withObject:responseObject];
        }
        [self.tableView reloadData];
    }];
}

- (void)requestMoreColumnCategory {
    [ChannelRequest getActorCategoriesFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            [self.hotColumnFilterArray removeAllObjects];
            NSArray *responseArray = responseObject;
            for (int i = 0; i < responseArray.count; i++) {
                NSDictionary *categoriesDic = responseArray[i];
                NSMutableDictionary *filterDic = [NSMutableDictionary dictionaryWithCapacity:0];
                [filterDic setObject:categoriesDic[@"name"] forKey:@"clsName"];
                [filterDic setObject:categoriesDic[@"id"] forKey:@"id"];
                [filterDic setObject:categoriesDic[@"rank"] forKey:@"rank"];
                [filterDic setObject:categoriesDic[@"deleteFlag"] forKey:@"deleteFlag"];
                [self.hotColumnFilterArray addObject:filterDic];
            }
            NSDictionary *dictionary = @{@"deleteFlag":@"",@"clsName":@"全部",@"id":@"",@"rank":@""};//构建一个全部的项
            [self.hotColumnFilterArray insertObject:dictionary atIndex:0];
        }
    }];
}

#pragma mark - cellDelegate

//点击栏目跳转
- (void)columnNavsCellClick:(NSDictionary *)navInfo {
    [self pushToTopicVCWithNavInfo:navInfo];
}

//更多专题
- (void)moreCategories {
    NSDictionary *columnInfo = self.tableList[2];
    HotColumnVC *hotColumnVC = [HotColumnVC instanceFromXib];
    hotColumnVC.title = columnInfo[@"modName"]?columnInfo[@"modName"]:@"";
    hotColumnVC.allColumns = columnInfo[@"subclass"]?columnInfo[@"subclass"]:@[];
    hotColumnVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hotColumnVC animated:YES];
}

//更多人气演员
- (void)actorTopicCellMoreHotActor {
    HotActorVC *hotActorVC = [HotActorVC instanceFromXib];
    hotActorVC.allClassList = self.hotColumnFilterArray.copy;
    hotActorVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hotActorVC animated:YES];
}

- (void)clickCategories:(NSDictionary *)categoriesInfo {
    [self pushToTopicVCWithNavInfo:categoriesInfo];
}

- (void)actorTopicCellClickMovie:(NSDictionary *)moiveDic {
    MoivesDetialVC *moivesDetialVC = [MoivesDetialVC instanceFromXib];
    moivesDetialVC.movieModel = [[MoivesModel alloc] initWithDetailDictionary:moiveDic];
    moivesDetialVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moivesDetialVC animated:YES];
}

- (void)pushToTopicVCWithNavInfo:(NSDictionary *)navInfo {
    MovieColumnModel *column = [[MovieColumnModel alloc] initWithChannelColumnDic:navInfo];
    SpecialTopicMoiveListVC *topicListVC = [SpecialTopicMoiveListVC instanceFromXib];
    topicListVC.columnModel = column;
    topicListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:topicListVC animated:YES];
}

#pragma mark - tableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //热门专题
        ColumnNavsCell *columnNavsCell = [tableView dequeueReusableCellWithIdentifier:ColumnNavsCellIdentifier];
        columnNavsCell.columnNavsCellDelegate = self;
        NSDictionary *cellData = self.tableList[indexPath.section];
        if (cellData && [cellData isKindOfClass:[NSDictionary class]]) {
            columnNavsCell.columnNavsInfo = cellData;
        }
        return columnNavsCell;
    } else if (indexPath.section == 1) {
        //广告
        ColumnAdCell *columnAdCell = [tableView dequeueReusableCellWithIdentifier:ColumnAdCellIdentifier];
        id cellData = self.tableList[indexPath.section];
        if (cellData && [cellData isKindOfClass:[NSArray class]]) {
            columnAdCell.adInfos = cellData;
        }
        return columnAdCell;
    }  else if (indexPath.section == 2) {
        //分类
        ActorCategoriesCell *categoriesCell = [tableView dequeueReusableCellWithIdentifier:ActorCategoriesCellIdentifier];
        categoriesCell.categoriesCellDelegate = self;
        NSDictionary *cellData = self.tableList[indexPath.section];
        if (cellData && [cellData isKindOfClass:[NSDictionary class]]) {
            categoriesCell.cellData = cellData;
        }
        
        return categoriesCell;
    } else {
        //热门演员
        ActorTopicCell *actorTopicCell = [tableView dequeueReusableCellWithIdentifier:ActorTopicCellIdentifier];
        actorTopicCell.actorTopicCellDelegate = self;
        NSArray *sectionData = self.tableList[indexPath.section];
        NSDictionary *cellData = sectionData[indexPath.row];
        if (cellData && [cellData isKindOfClass:[NSDictionary class]]) {
            actorTopicCell.cellData = cellData;
        }
        [actorTopicCell hidenTitle:(indexPath.row !=0)];
        return actorTopicCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 3) {
        return 1;
    } else {
        NSArray *cellData = self.tableList[section];
        return cellData.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}




@end
