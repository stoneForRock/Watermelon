//
//  MainNewestMovieCell.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MainNewestMovieCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MainNewestMovieCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet MovieCoverView *coverView1;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView2;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView3;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView4;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView5;
@property (weak, nonatomic) IBOutlet MovieCoverView *coverView6;

@property (nonatomic, strong) NSMutableArray *coverViewArray;

@end

@implementation MainNewestMovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.coverViewArray = [NSMutableArray arrayWithObjects:_coverView1,_coverView2,_coverView3,_coverView4,_coverView5,_coverView6, nil];
    
    for (MovieCoverView *coverView in self.coverViewArray) {
        UITapGestureRecognizer *tapImgGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapcoverView:)];
        [coverView addGestureRecognizer:tapImgGesture];
    }
}

- (void)setCellDataList:(NSArray *)cellDataList {
    _cellDataList = cellDataList;
    
    for (int i = 0; i < cellDataList.count; i ++) {
        if (i < 6) {
            MoivesModel *coverModel = cellDataList[i];
            MovieCoverView *coverView = self.coverViewArray[i];
            coverView.movieModel = coverModel;
        }
    }
}

- (void)setColumnModel:(MovieColumnModel *)columnModel {
    _columnModel = columnModel;
    [self showTitle:columnModel.name];
    if (columnModel && [columnModel.movies isKindOfClass:[NSArray class]]) {
        self.cellDataList = columnModel.movies;
    }
}

- (void)showTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (IBAction)moreAction:(UIButton *)sender {
    if (self.columnModel) {
        if (self.newestMovieCellDelegate != nil && [self.newestMovieCellDelegate respondsToSelector:@selector(topicDetialActionWithColumn:)]) {
            [self.newestMovieCellDelegate topicDetialActionWithColumn:self.columnModel];
        }
    } else {
        if (self.newestMovieCellDelegate != nil && [self.newestMovieCellDelegate respondsToSelector:@selector(newestMovieCellMoreAction)]) {
            [self.newestMovieCellDelegate newestMovieCellMoreAction];
        }
    }
}

- (void)tapcoverView:(UIGestureRecognizer *)gestureRecognizer {
    MovieCoverView *coverView = (MovieCoverView *)gestureRecognizer.view;
    NSInteger index = coverView.tag - 100;
    if (self.newestMovieCellDelegate != nil && [self.newestMovieCellDelegate respondsToSelector:@selector(newestMovieCellClickMoive:)]) {
        [self.newestMovieCellDelegate newestMovieCellClickMoive:self.cellDataList[index]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
