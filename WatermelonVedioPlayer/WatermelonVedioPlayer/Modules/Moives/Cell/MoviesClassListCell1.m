//
//  MoviesClassListCell1.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/18.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MoviesClassListCell1.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MoviesClassListCell1 ()

@property (weak, nonatomic) IBOutlet UIImageView *movieImgView;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@end

@implementation MoviesClassListCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMovieModel:(MoivesModel *)movieModel {
    _movieModel = movieModel;
    
    [self.movieImgView sd_setImageWithURL:[NSURL URLWithString:movieModel.cover]];
    self.movieNameLabel.text = movieModel.movName;
    self.playCountLabel.text = [NSString stringWithFormat:@"%.2f万次播放",[movieModel.playCount doubleValue]/10000];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
