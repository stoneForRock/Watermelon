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

#define ColumnNavsCellIdentifier @"ColumnNavsCell"
#define ColumnAdCellIdentifier @"ColumnAdCell"
#define ActorCategoriesCellIdentifier @"ActorCategoriesCell"
#define ActorTopicCellIdentifier @"ActorTopicCell"

@interface RecommendColumnVC ()<UITableViewDelegate, UITableViewDataSource, ActorCategoriesCellDelegate, ActorTopicCellDelegate, ColumnNavsCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableList;

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
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    self.tableView.tableHeaderView = tableHeaderView;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self regiserTableCell];
}

- (void)regiserTableCell {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ColumnNavsCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ColumnNavsCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ColumnAdCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ColumnAdCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActorCategoriesCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ActorCategoriesCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ActorTopicCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ActorTopicCellIdentifier];
}

- (void)initDataInfo {
    self.tableList = [NSMutableArray arrayWithObjects:@{},@[],@[],@[],nil];
}

- (void)requestColumnInfo {
    [self requestTopAdInfo];
    [self requestColumnNavs];
    [self requestHotsActor];
}

- (void)requestColumnNavs {
    [ChannelRequest getColumnNavsFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
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

#pragma mark - cellDelegate

//点击栏目跳转
- (void)columnNavsCellClick:(NSDictionary *)navInfo {
    
}

- (void)moreCategories {
    
}

- (void)clickCategories:(NSDictionary *)categoriesInfo {
    
}

- (void)actorTopicCellClickMovie:(MoivesModel *)moive {
    
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
        id cellData = self.tableList[indexPath.section];
        if (cellData && [cellData isKindOfClass:[NSArray class]]) {
            categoriesCell.cellDatas = cellData;
        }
        
        return categoriesCell;
    } else {
        //热门演员
        ActorTopicCell *actorTopicCell = [tableView dequeueReusableCellWithIdentifier:ActorTopicCellIdentifier];
        actorTopicCell.actorTopicCellDelegate = self;
        NSArray *sectionData = self.tableList[indexPath.section];
        id cellData = sectionData[indexPath.row];
        if (cellData && [cellData isKindOfClass:[NSArray class]]) {
            actorTopicCell.cellDataList = cellData;
        }
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
