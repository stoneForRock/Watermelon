//
//  HotActorVC.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/23.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "HotActorVC.h"
#import "HUDHelper.h"
#import <MJRefresh/MJRefresh.h>
#import "ChannelRequest.h"
#import "HotActorCell.h"

static NSString *const HotActorCellId = @"HotActorCellId";

@interface HotActorVC ()<FilterSortViewDelegate, FilterSortViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *collectList;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (strong, nonatomic) FilterSortView *filterSortView;

@property (nonatomic, copy) NSString *categoriesId;
@property (nonatomic, assign) NSInteger sortIndex;

@property (nonatomic, strong) NSArray *allColors;
@property (nonatomic, strong) NSArray *sortArray;
@end

@implementation HotActorVC
INSTANCE_XIB_M(@"Channel", HotActorVC)
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    
    [self initUI];
    
    [self requestData];
}

- (void)initDataInfo {
    self.collectList = [NSMutableArray arrayWithCapacity:0];
    self.allColors = @[COLORWITHRGBADIVIDE255(255, 182, 193, 1),COLORWITHRGBADIVIDE255(100, 149, 237, 1),COLORWITHRGBADIVIDE255(255, 222, 173, 1),COLORWITHRGBADIVIDE255(64, 224, 208, 1),COLORWITHRGBADIVIDE255(186, 85, 211, 1),COLORWITHRGBADIVIDE255(123, 104, 238, 1)];
    self.sortArray = @[@{@"sortName":@"影片人气",@"sortId":@"play_count",@"sortIndex":@"0"},@{@"sortName":@"影片量",@"sortId":@"movie_count",@"sortIndex":@"1"}];
}

- (void)initUI {
    self.title = @"演员列表";
    self.filterSortView = [[FilterSortView alloc] initWithFilterType:FilterSort frame:CGRectMake(0, SafeTopHeight, self.view.frame.size.width, 80) delegate:self dataSource:self];
    [self.view addSubview:self.filterSortView];
    
    [self createCollectionView];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((ScreenFullWidth - 50)/3, 140);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.filterSortView.frame), ScreenFullWidth, ScreenFullHeight - NavigationBarHeight - StatusBarHeight - CGRectGetHeight(self.filterSortView.frame)) collectionViewLayout:layout];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[HotActorCell class] forCellWithReuseIdentifier:HotActorCellId];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
}

- (void)requestData {
    [HUDHelper showHUDLoading:self.view text:@"请稍候..."];
    NSString *sortString = self.sortArray[self.sortIndex][@"sortId"];
    [ChannelRequest getActorListWithCategoryId:self.categoriesId sort:sortString finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        [HUDHelper hideHUDView:self.view];
        [self.collectionView.mj_header endRefreshing];
        if (success) {
            [self.collectList removeAllObjects];
            if (responseObject) {
                [self.collectList addObjectsFromArray:responseObject];
            }
            [self.collectionView reloadData];
            if (self.collectList.count > 0) {
                [self.collectionView hideNoDataView];
            } else {
                [self.collectionView showNoDataView:@"暂无演员数据"];
            }
        } else {
            [HUDHelper showHUDText:error.domain duration:1.5 inView:self.view];
        }
    }];
}

#pragma mark - UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotActorCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:HotActorCellId forIndexPath:indexPath];
    NSDictionary *cellInfo = self.collectList[indexPath.row];
    NSInteger colorIndex = indexPath.row%6;
    cell.bgColor = self.allColors[colorIndex];
    cell.cellInfo = cellInfo;
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//返回每个分区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectList.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cellInfo = self.collectList[indexPath.row];
    
}

#pragma mark - FilterSortViewDelegate

- (void)filterSortDidChangeWithSortData:(NSDictionary *)sortData filterData:(NSDictionary *)filterData {
    self.sortIndex = [sortData[@"sortIndex"] integerValue];
    self.categoriesId = filterData[@"id"];
    [self requestData];
}

- (NSInteger)defaultSortIndex {
    return self.sortIndex;
}

- (NSInteger)defaultFilterIndex {
    NSPredicate *classPre = [NSPredicate predicateWithFormat:@"self.id = %@",self.categoriesId];
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
    return self.sortArray;
}

@end
