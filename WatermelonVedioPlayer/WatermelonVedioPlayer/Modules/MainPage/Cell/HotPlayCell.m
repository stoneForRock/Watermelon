//
//  HotPlayCell.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/13.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "HotPlayCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HotPlayCell ()

@property (weak, nonatomic) IBOutlet UIView *exchangeView;

@property (weak, nonatomic) IBOutlet MovieCoverView *coverView1;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView2;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView3;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView4;

@property (nonatomic, strong) NSMutableArray *coverViewArray;

@end

@implementation HotPlayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.coverViewArray = [NSMutableArray arrayWithObjects:_coverView1,_coverView2,_coverView3,_coverView4, nil];
    
    for (MovieCoverView *coverView in self.coverViewArray) {
        UITapGestureRecognizer *tapImgGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapcoverView:)];
        [coverView addGestureRecognizer:tapImgGesture];
    }
    
    UITapGestureRecognizer *exchangeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exchangeAction)];
    [self.exchangeView addGestureRecognizer:exchangeGesture];
}

- (void)setCellDataList:(NSArray *)cellDataList {
    _cellDataList = cellDataList;
    for (int i = 0; i < cellDataList.count; i ++) {
        if (i < 4) {
            MoivesModel *coverModel = cellDataList[i];
            MovieCoverView *coverView = self.coverViewArray[i];
            coverView.movieModel = coverModel;
        }
    }
}

- (void)exchangeAction {
    if (self.hotPlayCellDelegate != nil && [self.hotPlayCellDelegate respondsToSelector:@selector(hotPlayCellExchangeAction)]) {
        [self.hotPlayCellDelegate hotPlayCellExchangeAction];
    }
}

- (IBAction)moreAction:(UIButton *)sender {
    if (self.hotPlayCellDelegate != nil && [self.hotPlayCellDelegate respondsToSelector:@selector(hotPlayCellMoreAction)]) {
        [self.hotPlayCellDelegate hotPlayCellMoreAction];
    }
}

- (void)tapcoverView:(UIGestureRecognizer *)gestureRecognizer {
    MovieCoverView *coverView = (MovieCoverView *)gestureRecognizer.view;
    NSInteger index = coverView.tag - 100;
    if (self.hotPlayCellDelegate != nil && [self.hotPlayCellDelegate respondsToSelector:@selector(hotPlayCellClickMovie:)]) {
        [self.hotPlayCellDelegate hotPlayCellClickMovie:self.cellDataList[index]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
