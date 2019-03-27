//
//  MoviesClassListCell2.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/18.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MoviesClassListCell2.h"

@interface MoviesClassListCell2 ()

@property (weak, nonatomic) IBOutlet MovieCoverView *coverView1;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView2;

@end

@implementation MoviesClassListCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setCellList:(NSArray *)cellList {
    
    self.coverView1.nameLabel.textColor = COLORWITHRGBADIVIDE255(55, 55, 55, 1);
    self.coverView2.nameLabel.textColor = COLORWITHRGBADIVIDE255(55, 55, 55, 1);
    _cellList = cellList;
    int count = (int)cellList.count;
    
    self.coverView1.hidden = YES;
    self.coverView2.hidden = YES;
    if (count > 0) {
        if (count < 2) {
            self.coverView1.hidden = NO;
            MoivesModel *movieModel = cellList[0];
            self.coverView1.movieModel = movieModel;
        } else {
            self.coverView1.hidden = NO;
            MoivesModel *movieModel1 = cellList[0];
            self.coverView1.movieModel = movieModel1;
            
            self.coverView2.hidden = NO;
            MoivesModel *movieModel2 = cellList[1];
            self.coverView2.movieModel = movieModel2;
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
