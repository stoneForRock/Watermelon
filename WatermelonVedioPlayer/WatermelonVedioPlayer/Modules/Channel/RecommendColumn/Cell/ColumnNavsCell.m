//
//  ColumnNavsCell.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/22.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "ColumnNavsCell.h"
#import "SpecialCardView.h"

@interface ColumnNavsCell ()<SpecialCardViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *navNameLabel;

@property (weak, nonatomic) IBOutlet SpecialCardView *cardView1;
@property (weak, nonatomic) IBOutlet SpecialCardView *cardView2;
@property (weak, nonatomic) IBOutlet SpecialCardView *cardView3;

@property (nonatomic, strong) NSMutableArray *cardViewArray;
@end

@implementation ColumnNavsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cardView1.specialCardViewDelegate = self;
    self.cardView2.specialCardViewDelegate = self;
    self.cardView3.specialCardViewDelegate = self;
    self.cardViewArray = [NSMutableArray arrayWithObjects:_cardView1,_cardView2,_cardView3, nil];
}

- (void)setColumnNavsInfo:(NSDictionary *)columnNavsInfo {
    _columnNavsInfo = columnNavsInfo;
    self.navNameLabel.text = columnNavsInfo[@"modName"]?columnNavsInfo[@"modName"]:@"";
    NSArray *navCards = columnNavsInfo[@"subclass"]?columnNavsInfo[@"subclass"]:@[];
    for (int i = 0; i < navCards.count; i ++) {
        if (i < 3) {
            NSDictionary *navInfo = navCards[i];
            SpecialCardView *cardView = self.cardViewArray[i];
            cardView.columnSubObj = navInfo;
        }
    }
}

- (void)clickSpecialCard:(NSDictionary *)columnInfo {
    if (self.columnNavsCellDelegate != nil && [self.columnNavsCellDelegate respondsToSelector:@selector(columnNavsCellClick:)]) {
        [self.columnNavsCellDelegate columnNavsCellClick:columnInfo];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
