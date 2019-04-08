//
//  FinderCell.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/8.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "FinderCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MoivesRequest.h"
#import "HUDHelper.h"

@interface FinderCell ()
@property (weak, nonatomic) IBOutlet UILabel *movNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *loveBtn;

@end

@implementation FinderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CAGradientLayer* gradinentlayer=[CAGradientLayer layer];
    gradinentlayer.colors=@[(__bridge id)[UIColor blackColor].CGColor,(__bridge id)[UIColor clearColor].CGColor];
    gradinentlayer.locations=@[@0.0,@1.0];
    gradinentlayer.startPoint=CGPointMake(0, 0);
    gradinentlayer.endPoint=CGPointMake(0, 1.0);
    gradinentlayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30);
    [self.coverImgView.layer addSublayer:gradinentlayer];
}

- (void)setMovieModel:(MoivesModel *)movieModel {
    _movieModel = movieModel;
    self.movNameLabel.text = movieModel.movName;
    self.playCountLabel.text = [NSString stringWithFormat:@"%.2f万次播放",[movieModel.playCount doubleValue]/10000];
    [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:movieModel.cover]];
}

- (IBAction)favAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [MoivesRequest addFavMovieWithId:self.movieModel.moiveId finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
            if (success) {
                self.movieModel.isFav = @"1";
            } else {
                [HUDHelper showHUDText:error.domain duration:1.5 inView:self];
                self.loveBtn.selected = NO;
            }
        }];
    } else {
        [MoivesRequest cancelFavMovieWithId:self.movieModel.moiveId finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
            if (success) {
                self.movieModel.isFav = @"0";
            } else {
                [HUDHelper showHUDText:error.domain duration:1.5 inView:self];
                self.loveBtn.selected = YES;
            }
        }];
    }
}

- (IBAction)downLoadAction:(UIButton *)sender {
    
}

- (IBAction)shareAction:(UIButton *)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
