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
    _cellList = cellList;
    int count = cellList.count;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
