//
//  HotPlayCell.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/13.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "HotPlayCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HotPlayCell ()

@property (weak, nonatomic) IBOutlet UIView *exchangeView;

@property (weak, nonatomic) IBOutlet UIImageView *imgview1;
@property (weak, nonatomic) IBOutlet UIImageView *imgview2;
@property (weak, nonatomic) IBOutlet UIImageView *imgview3;
@property (weak, nonatomic) IBOutlet UIImageView *imgview4;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSMutableArray *labelArray;

@end

@implementation HotPlayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imgArray = [NSMutableArray arrayWithObjects:_imgview1,_imgview2,_imgview3,_imgview4, nil];
    self.labelArray = [NSMutableArray arrayWithObjects:_label1,_label2,_label3,_label4, nil];
    
    UITapGestureRecognizer *exchangeGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exchangeAction)];
    [self.exchangeView addGestureRecognizer:exchangeGesture];
    
    for (UIImageView *imageView in self.imgArray) {
        UITapGestureRecognizer *tapImgGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgView:)];
        [imageView addGestureRecognizer:tapImgGesture];
    }
}

- (void)setCellDataList:(NSArray *)cellDataList {
    _cellDataList = cellDataList;
    for (int i = 0; i < cellDataList.count; i ++) {
        if (i < 4) {
            NSDictionary *cellInfo = cellDataList[i];
            UIImageView *imgView = self.imgArray[i];
            UILabel *titleLabel = self.labelArray[i];
            [imgView sd_setImageWithURL:[NSURL URLWithString:cellInfo[@"cover"]]];
            titleLabel.text = cellInfo[@"movName"];
        }
    }
}

- (void)exchangeAction {
    if (self.hotPlayCellDelegate != nil && [self.hotPlayCellDelegate respondsToSelector:@selector(hotPlayCellExchangeAction)]) {
        [self.hotPlayCellDelegate hotPlayCellExchangeAction];
    }
}

- (IBAction)moreAction:(UIButton *)sender {
    if (self.hotPlayCellDelegate != nil && [self.hotPlayCellDelegate respondsToSelector:@selector(hotPlayCellMoreAction)]) {
        [self.hotPlayCellDelegate hotPlayCellMoreAction];
    }
}

- (void)tapImgView:(UIGestureRecognizer *)gestureRecognizer {
    UIImageView *imageView = (UIImageView *)gestureRecognizer.view;
    NSInteger index = imageView.tag - 100;
    if (self.hotPlayCellDelegate != nil && [self.hotPlayCellDelegate respondsToSelector:@selector(hotPlayCellClickMovie:)]) {
        [self.hotPlayCellDelegate hotPlayCellClickMovie:self.cellDataList[index]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
