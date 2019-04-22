//
//  ActorTopicCell.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/19.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "ActorTopicCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ActorTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *actorIconImgView;
@property (weak, nonatomic) IBOutlet UILabel *actorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorIntroduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieCountLabel;

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

@implementation ActorTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
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
    if (self.actorTopicCellDelegate != nil && [self.actorTopicCellDelegate respondsToSelector:@selector(actorTopicCellClickMovie:)]) {
        [self.actorTopicCellDelegate actorTopicCellClickMovie:self.cellDataList[index]];
    }
}
- (IBAction)moreActorMovieAction:(UIButton *)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
