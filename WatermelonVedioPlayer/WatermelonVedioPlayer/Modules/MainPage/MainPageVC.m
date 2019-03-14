//
//  MainPageVC.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "MainPageVC.h"
#import "MainSearchVC.h"
#import "PlayHistoryVC.h"
#import "RollingCircleScroll.h"
#import "MainPageVC+Request.h"
#import "MainPageVC+Push.h"

#import "MainNewestMovieCell.h"
#import "MoiveClassCell.h"
#import "HotPlayCell.h"
#import "GussLikeCell.h"
#import "MainListADCell.h"

#define MoiveClassCellIdentifier  @"MoiveClassCell"
#define MainNewestMovieCellIdentifier  @"MainNewestMovieCell"
#define HotPlayCellIdentifier  @"HotPlayCell"
#define GussLikeCellIdentifier  @"GussLikeCell"
#define MainListADCellIdentifier  @"MainListADCell"

@interface MainPageVC ()<RollingCircleScrollDelegate, UITableViewDelegate, UITableViewDataSource, MoiveClassCellDelegate, MainNewestMovieCellDelegate, HotPlayCellDelegate, GussLikeCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) RollingCircleScroll *circleScroll;
@property (nonatomic, strong) UIView *navBarView;

@end

@implementation MainPageVC

INSTANCE_XIB_M(@"MainPage", MainPageVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataInfo];
    [self initUI];
    [self request];
}

- (void)initUI {
    self.view.backgroundColor = COLORWITHRGBADIVIDE255(29, 29, 29, 1);
    [self initNavBarView];
    [self createTableHeaderView];
    [self regiserTableCell];
}

- (void)initDataInfo {
    self.tableDataSource = [NSMutableDictionary dictionaryWithCapacity:0];
}

- (void)request {
    [self lunchRequest];
}

- (void)createTableHeaderView {
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
    self.tableView.tableHeaderView = tableHeaderView;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
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

- (void)refreshMoiveClassWithClass:(NSArray *)moiveClass {
    [self.tableDataSource setObject:moiveClass forKey:@"moiveClass"];
    [self.tableView reloadData];
}

- (void)refreshNewestMoiveWithList:(NSArray *)newestList {
    [self.tableDataSource setObject:newestList forKey:@"newestMoive"];
    [self.tableView reloadData];
}

- (void)refreshHotPlayMoiveWithList:(NSArray *)hotPlayList {
    [self.tableDataSource setObject:hotPlayList forKey:@"hotPlay"];
    [self.tableView reloadData];
}

- (void)refreshGussLikeMoiveWithList:(NSArray *)gussLikeList {
    [self.tableDataSource setObject:gussLikeList forKey:@"gussLike"];
    [self.tableView reloadData];
}

- (void)refreshMovieListADWithADList:(NSArray *)adList {
    for (int i = 0; i < adList.count; i ++ ) {
        NSString *key = [NSString stringWithFormat:@"ad%d",i+1];
        NSDictionary *adInfo = adList[i];
        [self.tableDataSource setObject:adInfo forKey:key];
    }
    [self.tableView reloadData];
}

- (void)refreshColumnList:(NSArray *)columnList {
    for (int i = 0; i < columnList.count; i ++ ) {
        NSString *key = [NSString stringWithFormat:@"column%d",i+1];
        MovieColumnModel *columnModel = columnList[i];
        [self.tableDataSource setObject:columnModel forKey:key];
    }
    [self.tableView reloadData];
}

- (void)initNavBarView {
    self.navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenFullWidth - 30, 44)];
    self.navigationItem.titleView = self.navBarView;
    
    UIView *searchBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, CGRectGetWidth(self.navBarView.frame) - 120, 34)];
    searchBgView.backgroundColor = COLORWITHRGBADIVIDE255(30, 30, 30, 1.0);
    searchBgView.layer.cornerRadius = 17.0;
    searchBgView.layer.masksToBounds = YES;
    [self.navBarView addSubview:searchBgView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction)];
    [searchBgView addGestureRecognizer:tapGesture];
    
    UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(searchBgView.frame), 34)];
    searchLabel.textColor = COLORWITHRGBADIVIDE255(151, 151, 151, 1.0);
    searchLabel.text = @"输入关键词查找片源";
    searchLabel.textAlignment = NSTextAlignmentCenter;
    searchLabel.font = [UIFont systemFontOfSize:14];
    [searchBgView addSubview:searchLabel];
    
    UIImageView *searchImgView = [[UIImageView alloc] initWithFrame:CGRectMake( 20, 6.5, 21, 21)];
    searchImgView.image = [UIImage imageNamed:@"search"];
    [searchBgView addSubview:searchImgView];
    
    UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [historyBtn setImage:[UIImage imageNamed:@"history"] forState:UIControlStateNormal];
    historyBtn.frame = CGRectMake(CGRectGetWidth(self.navBarView.frame) - 34, 5, 34, 34);
    [historyBtn addTarget:self action:@selector(pushToHistoryList) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView addSubview:historyBtn];
    
    UIButton *downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [downloadBtn setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    downloadBtn.frame = CGRectMake(CGRectGetMinX(historyBtn.frame) - 5 - 34, 5, 34, 34);
    [downloadBtn addTarget:self action:@selector(pushToDownloadList) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView addSubview:downloadBtn];
    
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanBtn setImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    scanBtn.frame = CGRectMake(CGRectGetMinX(downloadBtn.frame) - 5 - 34, 5, 34, 34);
    [scanBtn addTarget:self action:@selector(pushToScanList) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView addSubview:scanBtn];
}

- (void)regiserTableCell {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MoiveClassCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MoiveClassCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainNewestMovieCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MainNewestMovieCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HotPlayCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:HotPlayCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GussLikeCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:GussLikeCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainListADCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MainListADCellIdentifier];
}

#pragma mark - btnAction

//搜索
- (void)searchAction {
    MainSearchVC *searchVC = [MainSearchVC instanceFromXib];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}

//扫码
- (void)pushToScanList {
    
}

//下载
- (void)pushToDownloadList {
    
}

//历史记录
- (void)pushToHistoryList {
    PlayHistoryVC *historyVC = [PlayHistoryVC instanceFromXib];
    historyVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:historyVC animated:YES];
}

//点击滚动广告
- (void)rollingCircleScrollClickPage:(id)pageInfo {
    NSString *linkAddr = pageInfo[@"linkAddr"]?:@"";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkAddr] options:@{} completionHandler:nil];
}

#pragma mark - cellDelegate
- (void)clickMoiveClass:(NSDictionary *)classInfo {
    [self pushToMoiveClassListVCWithClassList:self.tableDataSource[@"moiveClass"] currentClassInfo:classInfo];
}

- (void)newestMovieCellClickMoive:(MoivesModel *)movieModel {
    [self pushToMoiveDetialVCWithMovieInfo:movieModel];
}

- (void)newestMovieCellMoreAction {
    
}

- (void)hotPlayCellExchangeAction {
    
}

- (void)hotPlayCellClickMovie:(MoivesModel *)movieModel {
    [self pushToMoiveDetialVCWithMovieInfo:movieModel];
}

- (void)hotPlayCellMoreAction {
    
}

- (void)gussLikeCellClickMovie:(MoivesModel *)moive {
    [self pushToMoiveDetialVCWithMovieInfo:moive];
}

#pragma mark - tableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //分类
        MoiveClassCell *classCell = [tableView dequeueReusableCellWithIdentifier:MoiveClassCellIdentifier];
        classCell.moiveClassCellDelegate = self;
        id cellData = self.tableDataSource[@"moiveClass"];
        if (cellData && [cellData isKindOfClass:[NSArray class]]) {
            classCell.cellDatas = cellData;
        }
        
        return classCell;
    } else if (indexPath.section == 1) {
        MainNewestMovieCell *newestCell = [tableView dequeueReusableCellWithIdentifier:MainNewestMovieCellIdentifier];
        newestCell.newestMovieCellDelegate = self;
        [newestCell showTitle:@"最新片源"];
        id cellData = self.tableDataSource[@"newestMoive"];
        if (cellData && [cellData isKindOfClass:[NSArray class]]) {
            newestCell.cellDataList = cellData;
        }
        return newestCell;
    } else if (indexPath.section == 2) {
        
        HotPlayCell *hotPlayCell = [tableView dequeueReusableCellWithIdentifier:HotPlayCellIdentifier];
        hotPlayCell.hotPlayCellDelegate = self;
        id cellData = self.tableDataSource[@"hotPlay"];
        if (cellData && [cellData isKindOfClass:[NSArray class]]) {
            hotPlayCell.cellDataList = cellData;
        }
        return hotPlayCell;
    } else if (indexPath.section == 3) {
        
        GussLikeCell *gussLikeCell = [tableView dequeueReusableCellWithIdentifier:GussLikeCellIdentifier];
        gussLikeCell.gussLikeCellDelegate = self;
        id cellData = self.tableDataSource[@"gussLike"];
        if (cellData && [cellData isKindOfClass:[NSArray class]]) {
            gussLikeCell.cellDataList = cellData;
        }
        return gussLikeCell;
        
    } else if (indexPath.section == 4) {
        MainListADCell *adCell = [tableView dequeueReusableCellWithIdentifier:MainListADCellIdentifier];
        id cellData = self.tableDataSource[@"ad1"];
        if (cellData && [cellData isKindOfClass:[NSDictionary class]]) {
            adCell.adInfo = cellData;
        }
        return adCell;
    } else {
        NSInteger index = indexPath.section%3;
        if (index == 1) {
            NSString *key = [NSString stringWithFormat:@"ad%d",(int)indexPath.section/3];
            MainListADCell *adCell = [tableView dequeueReusableCellWithIdentifier:MainListADCellIdentifier];
            id cellData = self.tableDataSource[key];
            if (cellData && [cellData isKindOfClass:[NSDictionary class]]) {
                adCell.adInfo = cellData;
            }
            return adCell;
        } else {
            NSString *key = [NSString stringWithFormat:@"column%d",(int)(indexPath.section - 4)/3 + 1];
            MovieColumnModel *columnModel = self.tableDataSource[key];
            MainNewestMovieCell *newestCell = [tableView dequeueReusableCellWithIdentifier:MainNewestMovieCellIdentifier];
            newestCell.newestMovieCellDelegate = self;
            [newestCell showTitle:columnModel.name];
            
            if (columnModel && [columnModel.movies isKindOfClass:[NSArray class]]) {
                newestCell.cellDataList = columnModel.movies;
            }
            return newestCell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableDataSource.allKeys.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 4) {
        NSDictionary *cellData = self.tableDataSource[@"ad1"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:cellData[@"linkAddr"]] options:@{} completionHandler:nil];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
