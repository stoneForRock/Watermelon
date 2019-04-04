//
//  MovieIntroduceView.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/4.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MovieIntroduceView.h"

@interface MovieIntroduceView ()
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieDesLabel;

@end

@implementation MovieIntroduceView

+ (MovieIntroduceView *)showIntroduceViewWithMovie:(MoivesModel *)movie rect:(CGRect)showRect inView:(UIView *)supView {
    MovieIntroduceView *introduceView = [[[UINib nibWithNibName:NSStringFromClass([MovieIntroduceView class]) bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    introduceView.movie = movie;
    introduceView.frame = CGRectMake(0, showRect.origin.y + showRect.size.height, showRect.size.width, showRect.size.height);
    [introduceView showInView:supView];
    return introduceView;
}

- (void)setMovie:(MoivesModel *)movie {
    _movie = movie;
    self.movieNameLabel.text = movie.movName;
    self.playCountLabel.text = [NSString stringWithFormat:@"播放：%.2f万次播放",[movie.playCount doubleValue]/10000];
    self.movieDesLabel.text = movie.movDesc;
}

- (void)showInView:(UIView *)supView {
    
    [supView addSubview:self];
    
    [UIView animateWithDuration:.3 animations:^{
        self.frame = CGRectMake(0, self.frame.origin.y - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:.2 animations:^{
        self.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)closeAction:(UIButton *)sender {
    [self dismiss];
}

@end
