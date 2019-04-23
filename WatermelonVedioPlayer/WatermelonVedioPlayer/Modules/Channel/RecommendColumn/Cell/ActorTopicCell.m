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

@property (weak, nonatomic) IBOutlet UILabel *titleNavLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

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
    
    self.actorIconImgView.layer.cornerRadius = 30.0;
    self.actorIconImgView.layer.masksToBounds = YES;
    self.actorIconImgView.layer.borderWidth = 3.0;
    self.actorIconImgView.layer.borderColor = ThemeColor.CGColor;
    
    self.coverViewArray = [NSMutableArray arrayWithObjects:_coverView1,_coverView2,_coverView3,_coverView4,_coverView5,_coverView6,_coverView7,_coverView8, nil];
    
    for (MovieCoverView *coverView in self.coverViewArray) {
        UITapGestureRecognizer *tapImgGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapcoverView:)];
        [coverView addGestureRecognizer:tapImgGesture];
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setCellData:(NSDictionary *)cellData {
    _cellData = cellData;
    [self.actorIconImgView sd_setImageWithURL:[NSURL URLWithString:cellData[@"photoUrl"]?cellData[@"photoUrl"]:@""]];
    self.actorNameLabel.text = cellData[@"nameCn"]?cellData[@"nameCn"]:@"";
    self.actorIntroduceLabel.text = cellData[@"briefIntroduction"]?cellData[@"briefIntroduction"]:@"";
    self.movieCountLabel.text = [NSString stringWithFormat:@"%@ 部影片",cellData[@"videosCount"]?cellData[@"videosCount"]:@""];
    NSArray *movies = cellData[@"movies"]?cellData[@"movies"]:@[];
    
    for (MovieCoverView *coverView in self.coverViewArray) {
        coverView.hidden = YES;
    }
    for (int i = 0; i < movies.count; i ++) {
        if (i < 8) {
            MoivesModel *coverModel = [[MoivesModel alloc] initWithDetailDictionary:movies[i]];
            MovieCoverView *coverView = self.coverViewArray[i];
            coverView.movieModel = coverModel;
            coverView.hidden = NO;
        }
    }
}

- (void)tapcoverView:(UIGestureRecognizer *)gestureRecognizer {
    MovieCoverView *coverView = (MovieCoverView *)gestureRecognizer.view;
    NSInteger index = coverView.tag - 100;
    NSArray *movies = self.cellData[@"movies"]?self.cellData[@"movies"]:@[];
    if (self.actorTopicCellDelegate != nil && [self.actorTopicCellDelegate respondsToSelector:@selector(actorTopicCellClickMovie:)]) {
        [self.actorTopicCellDelegate actorTopicCellClickMovie:movies[index]];
    }
}

- (void)hidenTitle:(BOOL)hidden {
    self.titleNavLabel.hidden = hidden;
    self.moreBtn.hidden = hidden;
}

- (IBAction)moreActorMovieAction:(UIButton *)sender {
    if (self.actorTopicCellDelegate != nil && [self.actorTopicCellDelegate respondsToSelector:@selector(actorTopicCellMoreHotActor)]) {
        [self.actorTopicCellDelegate actorTopicCellMoreHotActor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
