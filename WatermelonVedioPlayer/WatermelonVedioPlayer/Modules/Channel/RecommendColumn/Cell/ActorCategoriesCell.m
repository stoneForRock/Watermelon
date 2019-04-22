//
//  ActorCategoriesCell.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/19.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "ActorCategoriesCell.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface ActorCategoriesCell ()
@property (weak, nonatomic) IBOutlet UILabel *navNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet UIButton *btn7;
@property (weak, nonatomic) IBOutlet UIButton *btn8;

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UILabel *lab5;
@property (weak, nonatomic) IBOutlet UILabel *lab6;
@property (weak, nonatomic) IBOutlet UILabel *lab7;
@property (weak, nonatomic) IBOutlet UILabel *lab8;

@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) NSMutableArray *labelArray;

@end

@implementation ActorCategoriesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btn1.layer.cornerRadius = 30.0;
    self.btn2.layer.cornerRadius = 30.0;
    self.btn3.layer.cornerRadius = 30.0;
    self.btn4.layer.cornerRadius = 30.0;
    self.btn5.layer.cornerRadius = 30.0;
    self.btn6.layer.cornerRadius = 30.0;
    self.btn7.layer.cornerRadius = 30.0;
    self.btn8.layer.cornerRadius = 30.0;
    
    self.btnArray = [NSMutableArray arrayWithObjects:_btn1,_btn2,_btn3,_btn4,_btn5,_btn6,_btn7,_btn8, nil];
    self.labelArray = [NSMutableArray arrayWithObjects:_lab1,_lab2,_lab3,_lab4,_lab5,_lab6,_lab7,_lab8, nil];
}

- (void)setCellDatas:(NSArray *)cellDatas {
    _cellDatas = cellDatas;
    for (int i = 0; i < cellDatas.count; i ++) {
        if (i < 8) {
            NSDictionary *categoriesInfo = cellDatas[i];
            UIButton *button = self.btnArray[i];
            UILabel *label = self.labelArray[i];
            [button sd_setImageWithURL:[NSURL URLWithString:categoriesInfo[@"navImage"]] forState:UIControlStateNormal];
            label.text = categoriesInfo[@"navName"];
        }
    }
}

- (IBAction)clickCategoriesInfo:(UIButton *)sender {
    NSInteger index = sender.tag - 101;
    if (index < self.cellDatas.count) {
        NSDictionary *categoriesInfo = self.cellDatas[index];
        if (self.categoriesCellDelegate != nil && [self.categoriesCellDelegate respondsToSelector:@selector(clickCategories:)]) {
            [self.categoriesCellDelegate clickCategories:categoriesInfo];
        }
    }
}
- (IBAction)moreAction:(UIButton *)sender {
    
    if (self.categoriesCellDelegate != nil && [self.categoriesCellDelegate respondsToSelector:@selector(moreCategories)]) {
        [self.categoriesCellDelegate moreCategories];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
