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

@property (weak, nonatomic) IBOutlet UIImageView *imgview1;
@property (weak, nonatomic) IBOutlet UIImageView *imgview2;
@property (weak, nonatomic) IBOutlet UIImageView *imgview3;
@property (weak, nonatomic) IBOutlet UIImageView *imgview4;
@property (weak, nonatomic) IBOutlet UIImageView *imgview5;
@property (weak, nonatomic) IBOutlet UIImageView *imgview6;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;

@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSMutableArray *labelArray;

@end

@implementation MainNewestMovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imgArray = [NSMutableArray arrayWithObjects:_imgview1,_imgview2,_imgview3,_imgview4,_imgview5,_imgview6, nil];
    self.labelArray = [NSMutableArray arrayWithObjects:_label1,_label2,_label3,_label4,_label5,_label6, nil];
    
    for (UIImageView *imageView in self.imgArray) {
        UITapGestureRecognizer *tapImgGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgView:)];
        [imageView addGestureRecognizer:tapImgGesture];
    }
}

- (void)setCellDataList:(NSArray *)cellDataList {
    _cellDataList = cellDataList;
    
    for (int i = 0; i < cellDataList.count; i ++) {
        if (i < 6) {
            NSDictionary *cellInfo = cellDataList[i];
            UIImageView *imgView = self.imgArray[i];
            UILabel *titleLabel = self.labelArray[i];
            [imgView sd_setImageWithURL:[NSURL URLWithString:cellInfo[@"cover"]]];
            titleLabel.text = cellInfo[@"movName"];
        }
    }
    
}

- (void)showTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (IBAction)moreAction:(UIButton *)sender {
    if (self.newestMovieCellDelegate != nil && [self.newestMovieCellDelegate respondsToSelector:@selector(newestMovieCellMoreAction)]) {
        [self.newestMovieCellDelegate newestMovieCellMoreAction];
    }
}

- (void)tapImgView:(UIGestureRecognizer *)gestureRecognizer {
    UIImageView *imageView = (UIImageView *)gestureRecognizer.view;
    NSInteger index = imageView.tag - 100;
    if (self.newestMovieCellDelegate != nil && [self.newestMovieCellDelegate respondsToSelector:@selector(newestMovieCellClickMoive:)]) {
        [self.newestMovieCellDelegate newestMovieCellClickMoive:self.cellDataList[index]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
