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
    // Initialization code
}

- (void)setCellList:(NSArray *)cellList {
    _cellList = cellList;
    int count = (int)cellList.count;
    
    self.coverView1.hidden = YES;
    self.coverView2.hidden = YES;
    self.coverView3.hidden = YES;
    if (count > 0) {
        if (count == 1) {
            self.coverView1.hidden = NO;
            MoivesModel *movieModel = cellList[0];
            self.coverView1.movieModel = movieModel;
        } else if (count == 2){
            self.coverView2.hidden = NO;
            MoivesModel *movieModel = cellList[1];
            self.coverView2.movieModel = movieModel;
        } else {
            self.coverView3.hidden = NO;
            MoivesModel *movieModel = cellList[2];
            self.coverView3.movieModel = movieModel;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
