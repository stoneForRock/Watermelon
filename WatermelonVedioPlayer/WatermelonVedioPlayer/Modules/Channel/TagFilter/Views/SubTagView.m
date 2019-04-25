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
        layout.itemSize = CGSizeMake(frame.size.width/2 - 30, 30);
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 50) collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.collectionView registerClass:[TagCollectionCell class] forCellWithReuseIdentifier:TagCollectionCellIdentifier];
        [self addSubview:self.collectionView];
        
        self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.confirmBtn setBackgroundImage:[UIImage imageNamed:@"normal_btn"] forState:UIControlStateNormal];
        [self.confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        self.confirmBtn.bounds = CGRectMake(0, 0, 200, 40);
        self.confirmBtn.center = CGPointMake(ScreenFullWidth/2, CGRectGetMaxY(self.collectionView.frame) + 25);
        self.confirmBtn.hidden = YES;
        [self addSubview:self.confirmBtn];
        
    }
    return self;
}

- (void)refreshWithDataList:(NSArray *)dataList selectedIds:(NSArray *)selectedIds {
    self.collectionList = [NSMutableArray arrayWithArray:dataList];
    self.markedIdList = [NSMutableArray arrayWithArray:selectedIds];
    [self.collectionView reloadData];
}

- (void)refreshSelectedIds:(NSArray *)selectedIds {
    self.markedIdList = [NSMutableArray arrayWithArray:selectedIds];
    [self.collectionView reloadData];
}

- (void)confirmAction {
    if (self.subTagViewDelegate != nil && [self.subTagViewDelegate respondsToSelector:@selector(subTagViewConfirmSelectedTagIds:)]) {
        [self.subTagViewDelegate subTagViewConfirmSelectedTagIds:self.markedIdList.copy];
    }
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
    cell.tagName = cellInfo[@"name"]?cellInfo[@"name"]:@"";
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//返回每个分区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.markedIdList.count > 0) {
        self.confirmBtn.hidden = NO;
    } else {
        self.confirmBtn.hidden = YES;
    }
    return self.collectionList.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cellInfo = self.collectionList[indexPath.row];
    if (self.subTagViewDelegate != nil && [self.subTagViewDelegate respondsToSelector:@selector(subTagViewSelectedTagInfo:)]) {
        [self.subTagViewDelegate subTagViewSelectedTagInfo:cellInfo];
    }
    [self.collectionView reloadData];
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
    self.marked = self.marked;
}

- (void)setMarked:(BOOL)marked {
    _marked = marked;
    if (self.marked) {
        self.markImgview.frame = CGRectMake(15, 8, 12, 12);
    } else {
        self.markImgview.frame = CGRectMake(10, 0, 0, 0);
    }
    self.tagLabel.frame = CGRectMake(CGRectGetMaxX(self.markImgview.frame) + 5, 5, 120, 18);
}

- (void)setTagName:(NSString *)tagName {
    _tagName = tagName;
    self.tagLabel.text = tagName;
}

@end
