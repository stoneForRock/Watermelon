//
//  HotColumnVC.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/23.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "HotColumnVC.h"
#import "HotColumnCell.h"
#import "SpecialTopicMoiveListVC.h"

static NSString *const collectionCellId = @"collectionCellId";

@interface HotColumnVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *collectList;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HotColumnVC

INSTANCE_XIB_M(@"Channel", HotColumnVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    
    [self initUI];
    
}

- (void)initDataInfo {
    self.collectList = [NSMutableArray arrayWithArray:self.allColumns];
}

- (void)initUI {
    self.title = @"热门专题";
    [self createCollectionView];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((ScreenFullWidth - 50)/4, 120);
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.collectionView registerClass:[HotColumnCell class] forCellWithReuseIdentifier:collectionCellId];
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotColumnCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellId forIndexPath:indexPath];
    NSDictionary *cellInfo = self.collectList[indexPath.row];
    cell.cellInfo = cellInfo;
    return cell;
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
    MovieColumnModel *column = [[MovieColumnModel alloc] initWithChannelColumnDic:cellInfo];
    SpecialTopicMoiveListVC *topicListVC = [SpecialTopicMoiveListVC instanceFromXib];
    topicListVC.columnModel = column;
    topicListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:topicListVC animated:YES];
}

@end
