//
//  MoviesClassListCell3.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/18.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MoviesClassListCell3.h"

@interface MoviesClassListCell3 ()

@property (weak, nonatomic) IBOutlet MovieCoverView *coverView1;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView2;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView3;

@end

@implementation MoviesClassListCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapItem1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem1:)];
    [self.coverView1 addGestureRecognizer:tapItem1];
    
    UITapGestureRecognizer *tapItem2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem2:)];
    [self.coverView2 addGestureRecognizer:tapItem2];
    
    UITapGestureRecognizer *tapItem3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapItem3:)];
    [self.coverView3 addGestureRecognizer:tapItem3];
    
}

- (void)tapItem1:(UIGestureRecognizer *)tapGesture {
    if (self.moviesClassListCell3Delegate != nil && [self.moviesClassListCell3Delegate respondsToSelector:@selector(tapMoiveItemAction:)]) {
        [self.moviesClassListCell3Delegate tapMoiveItemAction:_cellList[0]];
    }
}

- (void)tapItem2:(UIGestureRecognizer *)tapGesture {
    if (self.moviesClassListCell3Delegate != nil && [self.moviesClassListCell3Delegate respondsToSelector:@selector(tapMoiveItemAction:)]) {
        [self.moviesClassListCell3Delegate tapMoiveItemAction:_cellList[1]];
    }
}

- (void)tapItem3:(UIGestureRecognizer *)tapGesture {
    if (self.moviesClassListCell3Delegate != nil && [self.moviesClassListCell3Delegate respondsToSelector:@selector(tapMoiveItemAction:)]) {
        [self.moviesClassListCell3Delegate tapMoiveItemAction:_cellList[2]];
    }
}

- (void)setCellList:(NSArray *)cellList {
    self.coverView1.nameLabel.textColor = COLORWITHRGBADIVIDE255(55, 55, 55, 1);
    self.coverView2.nameLabel.textColor = COLORWITHRGBADIVIDE255(55, 55, 55, 1);
    self.coverView3.nameLabel.textColor = COLORWITHRGBADIVIDE255(55, 55, 55, 1);
    _cellList = cellList;
    int count = (int)cellList.count;
    
    self.coverView1.hidden = YES;
    self.coverView2.hidden = YES;
    self.coverView3.hidden = YES;
    if (count > 0) {
        if (count == 1) {
            self.coverView1.hidden = NO;
            MoivesModel *movieModel1 = cellList[0];
            self.coverView1.movieModel = movieModel1;
        } else if (count == 2){
            self.coverView1.hidden = NO;
            MoivesModel *movieModel1 = cellList[0];
            self.coverView1.movieModel = movieModel1;
            
            self.coverView2.hidden = NO;
            MoivesModel *movieModel2 = cellList[1];
            self.coverView2.movieModel = movieModel2;
        } else {
            self.coverView1.hidden = NO;
            MoivesModel *movieModel1 = cellList[0];
            self.coverView1.movieModel = movieModel1;
            
            self.coverView2.hidden = NO;
            MoivesModel *movieModel2 = cellList[1];
            self.coverView2.movieModel = movieModel2;
            
            self.coverView3.hidden = NO;
            MoivesModel *movieModel3 = cellList[2];
            self.coverView3.movieModel = movieModel3;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
