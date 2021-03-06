//
//  GussLikeCell.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/13.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "GussLikeCell.h"

@interface GussLikeCell ()

@property (weak, nonatomic) IBOutlet MovieCoverView *coverView1;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView2;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView3;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView4;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView5;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView6;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView7;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView8;

@property (nonatomic, strong) NSMutableArray *coverViewArray;

@end

@implementation GussLikeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.coverViewArray = [NSMutableArray arrayWithObjects:_coverView1,_coverView2,_coverView3,_coverView4,_coverView5,_coverView6,_coverView7,_coverView8, nil];
    
    for (MovieCoverView *coverView in self.coverViewArray) {
        UITapGestureRecognizer *tapImgGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapcoverView:)];
        [coverView addGestureRecognizer:tapImgGesture];
    }
}

- (void)setCellDataList:(NSArray *)cellDataList {
    _cellDataList = cellDataList;
    for (int i = 0; i < cellDataList.count; i ++) {
        if (i < 8) {
            MoivesModel *coverModel = cellDataList[i];
            MovieCoverView *coverView = self.coverViewArray[i];
            coverView.movieModel = coverModel;
        }
    }
}

- (void)tapcoverView:(UIGestureRecognizer *)gestureRecognizer {
    MovieCoverView *coverView = (MovieCoverView *)gestureRecognizer.view;
    NSInteger index = coverView.tag - 100;
    if (self.gussLikeCellDelegate != nil && [self.gussLikeCellDelegate respondsToSelector:@selector(gussLikeCellClickMovie:)]) {
        [self.gussLikeCellDelegate gussLikeCellClickMovie:self.cellDataList[index]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
