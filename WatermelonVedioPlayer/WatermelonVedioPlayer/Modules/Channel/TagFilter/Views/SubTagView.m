//
//  SubTagView.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/24.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "SubTagView.h"

#define TagCollectionCellIdentifier @"TagCollectionCell"

@interface SubTagView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) NSMutableArray *collectionList;

@property (nonatomic, strong) NSMutableArray *markedIdList;

@end


@implementation SubTagView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.markedIdList = [NSMutableArray arrayWithCapacity:0];
        self.collectionList = [NSMutableArray arrayWithCapacity:0];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(ScreenFullWidth/2, 30);
        self.collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        self.collectionView.delegate=self;
        self.collectionView.dataSource=self;
        [self.collectionView registerClass:[TagCollectionCell class] forCellWithReuseIdentifier:TagCollectionCellIdentifier];
        [self addSubview:self.collectionView];
        
    }
    return self;
}

- (void)refreshWithDataList:(NSArray *)dataList selectedIds:(NSArray *)selectedIds {
    self.collectionList = [NSMutableArray arrayWithArray:dataList];
    self.markedIdList = [NSMutableArray arrayWithArray:selectedIds];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TagCollectionCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:TagCollectionCellIdentifier forIndexPath:indexPath];
    NSDictionary *cellInfo = self.collectionList[indexPath.row];
    NSString *tagId = cellInfo[@"id"];
    if ([self.markedIdList containsObject:tagId]) {
        cell.marked = YES;
    } else {
        cell.marked = NO;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//返回每个分区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionList.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cellInfo = self.collectionList[indexPath.row];
    if (self.subTagViewDelegate != nil && [self.subTagViewDelegate respondsToSelector:@selector(subTagViewSelectedTagInfo:)]) {
        [self.subTagViewDelegate subTagViewSelectedTagInfo:cellInfo];
    }
}

@end

@interface TagCollectionCell ()

@property (nonatomic, strong) UIImageView *markImgview;
@property (nonatomic, strong) UILabel *tagLabel;

@end

@implementation TagCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.markImgview = [[UIImageView alloc] init];
        self.markImgview.image = [UIImage imageNamed:@"tag_mark"];
        [self addSubview:self.markImgview];
        
        self.tagLabel = [[UILabel alloc] init];
        self.tagLabel.textColor = COLORWITHRGBADIVIDE255(55, 55, 55, 1);
        self.tagLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.tagLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.marked) {
        self.markImgview.frame = CGRectMake(15, 8, 12, 12);
    } else {
        self.markImgview.frame = CGRectMake(15, 0, 0, 0);
    }
    self.tagLabel.frame = CGRectMake(CGRectGetMaxX(self.markImgview.frame) + 5, 5, 120, 18);
}

- (void)setTagName:(NSString *)tagName {
    _tagName = tagName;
    self.tagLabel.text = tagName;
}

@end
