//
//  MovieCover1View.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/14.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MovieCoverView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MovieCoverView ()

@property (strong, nonatomic) IBOutlet UIView *coverContentView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *scoreBgView;

@end

@implementation MovieCoverView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.coverContentView = [[[NSBundle mainBundle] loadNibNamed:@"MovieCoverView" owner:self options:nil] lastObject];
    self.coverContentView.frame = self.bounds;
    [self addSubview:self.coverContentView];
}

- (void)setMovieModel:(MoivesModel *)movieModel {
    _movieModel = movieModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:movieModel.cover]];
    self.nameLabel.text = movieModel.movName;
    self.scoreLabel.text = movieModel.movScore;
}

@end
