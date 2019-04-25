//
//  TagFilterVC.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/4/13.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "TagFilterVC.h"
#import "ChannelRequest.h"
#import "TagFilterView.h"
#import "SubTagView.h"
#import "HUDHelper.h"
#import "MoivesModel.h"
#import <MJRefresh/MJRefresh.h>
#import "MoviesClassListCell1.h"
#import "MoivesDetialVC.h"

#define MoviesClassListCell1Identifier  @"MoviesClassListCell1"

@interface TagFilterVC ()<TagFilterViewDelegate, SubTagViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableList;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *allTagList;
@property (nonatomic, strong) NSMutableArray *allSelectedTagIdList;

@property (nonatomic, strong) TagFilterView *tagFilterView;
@property (nonatomic, strong) SubTagView *subTagView;

@end

@implementation TagFilterVC
INSTANCE_XIB_M(@"Channel", TagFilterVC)
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    [self initUI];
    [self requestData];

}

- (void)initDataInfo {
    self.currentPage = 1;
    self.tableList = [NSMutableArray arrayWithCapacity:0];
    self.allTagList = [NSMutableArray arrayWithCapacity:0];
    self.allSelectedTagIdList = [NSMutableArray arrayWithCapacity:0];
}

- (void)initUI {
    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeTopHeight + 70, ScreenFullWidth, self.view.frame.size.height - SafeTopHeight - 70 - 49)];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MoviesClassListCell1 class]) bundle:nil] forCellReuseIdentifier:MoviesClassListCell1Identifier];
}

- (void)createTagFilterView {
    self.tagFilterView = [[TagFilterView alloc] initWithFrame:CGRectMake(0, SafeTopHeight, ScreenFullWidth, 70) tagList:self.allTagList];
    self.tagFilterView.tagFilterViewDelegate = self;
    [self.view addSubview:self.tagFilterView];
    
    self.subTagView = [[SubTagView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tagFilterView.frame) + 30, ScreenFullWidth, 300)];
    self.subTagView.subTagViewDelegate = self;
    [self.view addSubview:self.subTagView];
    [self.subTagView refreshWithDataList:self.allTagList[0][@"subclass"] selectedIds:self.allSelectedTagIdList.copy];
}

- (void)requestData {
    [self requestTags];
}

- (void)requestTags {
    [ChannelRequest getTagListFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            NSArray *responseArray = responseObject;
            if (responseArray.count > 0) {
                NSMutableDictionary *allTagDic = [NSMutableDictionary dictionaryWithCapacity:0];
                [allTagDic setObject:@"0" forKey:@"pid"];
                [allTagDic setObject:@"全部" forKey:@"pname"];
                NSMutableArray *allTagSubClass = [NSMutableArray arrayWithCapacity:0];
                for (int i = 0; i < responseArray.count; i ++ ) {
                    NSDictionary *tagInfo = responseArray[i];
                    [allTagSubClass addObjectsFromArray:tagInfo[@"subclass"]?tagInfo[@"subclass"]:@[]];
                }
                [allTagDic setObject:allTagSubClass forKey:@"subclass"];
                [self.allTagList addObject:allTagDic];
                [self.allTagList addObjectsFromArray:responseArray];
                [self createTagFilterView];
            }
        }
    }];
}

- (void)requestTagMovies {
    self.subTagView.hidden = YES;
    self.tableView.hidden = NO;
    [HUDHelper showHUDLoading:self.view text:@"请稍候..."];
    [ChannelRequest queryMovieWithTagIds:self.allSelectedTagIdList.copy page:self.currentPage finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        [HUDHelper hideHUDView:self.view];
        [self.tableView.mj_footer endRefreshing];
        if (success) {
            if (self.currentPage == 1) {
                [self.tableList removeAllObjects];
            }
            NSArray *pageData = responseObject[@"data"];
            if (10 == pageData.count) {
                self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.currentPage = self.currentPage+1;
                    [self requestTagMovies];
                }];
            } else {
                self.tableView.mj_footer = nil;
            }
            for (NSDictionary *movieDic in pageData) {
                MoivesModel *model = [[MoivesModel alloc] initWithDictionary:movieDic error:nil];
                if (model) {
                    [self.tableList addObject:model];
                }
            }
            [self.tableView reloadData];
            if (self.tableList.count > 0) {
                [self.tableView hideNoDataView];
            } else {
                [self.tableView showNoDataView:@"暂无该系列影片"];
            }
        } else {
            [HUDHelper showHUDWithErrorText:error.domain inView:self.view];
        }
    }];
}

#pragma mark - TagFilterViewDelegate
- (void)tagFilterViewSelectedSupTagInfo:(NSDictionary *)supTagInfo {
    [self resetTableView];
    [self.subTagView refreshWithDataList:supTagInfo[@"subclass"] selectedIds:self.allSelectedTagIdList.copy];
}

- (void)tagFilterViewResetAll {
    [self resetTableView];
    [self.allSelectedTagIdList removeAllObjects];
    [self.tagFilterView refreshSelectedIds:self.allSelectedTagIdList.copy];
    [self.subTagView refreshWithDataList:self.allTagList[0][@"subclass"] selectedIds:self.allSelectedTagIdList.copy];
}

- (void)resetTableView {
    self.currentPage = 1;
    self.subTagView.hidden = NO;
    self.tableView.hidden = YES;
    [self.tableList removeAllObjects];
    [self.tableView reloadData];
}

#pragma mark - SubTagViewDelegate
- (void)subTagViewSelectedTagInfo:(NSDictionary *)tagInfo {
    NSString *tagId = tagInfo[@"id"];
    [self.allSelectedTagIdList addObject:tagId];
    [self.tagFilterView refreshSelectedIds:self.allSelectedTagIdList.copy];
    [self.subTagView refreshSelectedIds:self.allSelectedTagIdList.copy];
}

- (void)subTagViewConfirmSelectedTagIds:(NSArray *)allSelectedIds {
    [self requestTagMovies];
}

#pragma mark - tableDelegate

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
