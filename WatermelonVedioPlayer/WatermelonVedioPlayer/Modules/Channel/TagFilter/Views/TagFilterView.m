//
//  TagFilterView.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/23.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "TagFilterView.h"
#import "NSString+Tool.h"

@interface TagFilterView ()

@property (nonatomic, strong) NSArray *allTagList;

@property (nonatomic, strong) NSMutableArray *allSubClass;
@end

@implementation TagFilterView

- (instancetype)initWithFrame:(CGRect)frame tagList:(NSArray *)tagList {
    self = [super initWithFrame:frame];
    if (self) {
        self.allSubClass = [NSMutableArray arrayWithCapacity:0];
        self.allTagList = tagList;
        CGFloat btnX = 10;
        CGFloat btnY = 10;
        for (int i = 0; i < tagList.count; i ++) {
            NSDictionary *tagInfo = tagList[i];
            UIButton *filterBtn = [UIButton buttonWithTagTitle:tagInfo[@"pname"]?tagInfo[@"pname"]:@"" btnHeight:25];
            if (btnX + filterBtn.frame.size.width + 10 > ScreenFullWidth) {
                btnX = 10;
                btnY = btnY + 35;
            }
            [filterBtn addTarget:self action:@selector(filterAction:) forControlEvents:UIControlEventTouchUpInside];
            filterBtn.center = CGPointMake(filterBtn.bounds.size.width/2 + btnX, btnY + 25/2);
            filterBtn.tag = 99 + i;
            [self addSubview:filterBtn];
            btnX += filterBtn.bounds.size.width + 10;
            
            NSArray *subClass = tagInfo[@"subclass"]?tagInfo[@"subclass"]:@[];
            [self.allSubClass addObjectsFromArray:subClass];
        }
        
        UIButton *resetBtn = [UIButton buttonWithTagTitle:@"重置" btnHeight:25];
        if (btnX + resetBtn.frame.size.width + 10 > ScreenFullWidth) {
            btnX = 10;
            btnY = btnY + 35;
        }
        [resetBtn addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
        resetBtn.center = CGPointMake(resetBtn.bounds.size.width/2 + btnX, btnY + 25/2);
        [self addSubview:resetBtn];
    }
    return self;
}

- (void)refreshSelectedIds:(NSArray *)selectedIds {
    for (id subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *sender = (UIButton *)subView;
            [sender markTag:NO];
        }
    }
    for (NSString *subClassId in selectedIds) {
        NSPredicate *subPredicate = [NSPredicate predicateWithFormat:@"self.id = %@",subClassId];
        NSArray *filterArray = [self.allSubClass filteredArrayUsingPredicate:subPredicate];
        if (filterArray.count > 0) {
            NSDictionary *subClassDic = [filterArray lastObject];
            NSString *pid = subClassDic[@"categoryId"];
            NSPredicate *parPredicate = [NSPredicate predicateWithFormat:@"self.pid = %@",pid];
            NSArray *parFilterArray = [self.allTagList filteredArrayUsingPredicate:parPredicate];
            if (parFilterArray.count > 0) {
                NSDictionary *parTagInfo = [parFilterArray lastObject];
                NSInteger index = [self.allTagList indexOfObject:parTagInfo];
                UIButton *selectedBtn = [self viewWithTag:index + 99];
                [selectedBtn markTag:YES];
            }
        }
    }
}

- (void)filterAction:(UIButton *)sender {
    for (id subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)subView;
            UIView *borderView = subBtn.subviews[0];
            if (subBtn == sender) {
                subBtn.selected = YES;
                borderView.layer.borderColor = COLORWITHRGBADIVIDE255(194, 154, 104, 1).CGColor;
                borderView.layer.borderWidth = 0.5;
            } else {
                subBtn.selected = NO;
                borderView.layer.borderWidth = 0.0;
            }
        }
    }
    NSInteger index = sender.tag - 99;
    NSDictionary *tagInfo = self.allTagList[index];
    if (self.tagFilterViewDelegate != nil && [self.tagFilterViewDelegate respondsToSelector:@selector(tagFilterViewSelectedSupTagInfo:)]) {
        [self.tagFilterViewDelegate tagFilterViewSelectedSupTagInfo:tagInfo];
    }
}

- (void)resetAction:(UIButton *)sender {
    UIButton *allSender = [self viewWithTag:99];
    [self filterAction:allSender];
    if (self.tagFilterViewDelegate != nil && [self.tagFilterViewDelegate respondsToSelector:@selector(tagFilterViewResetAll)]) {
        [self.tagFilterViewDelegate tagFilterViewResetAll];
    }
}

@end

@implementation UIButton (tagFilter)
#define CheckMarkTag 190392
+ (instancetype)buttonWithTagTitle:(NSString *)title btnHeight:(CGFloat)btnHeight; {
    UIButton *filterSortBtn = [self buttonWithType:UIButtonTypeCustom];
    [filterSortBtn setTitle:title forState:UIControlStateNormal];
    [filterSortBtn setTitleColor:COLORWITHRGBADIVIDE255(55, 55, 55, 1) forState:UIControlStateNormal];
    [filterSortBtn setTitleColor:COLORWITHRGBADIVIDE255(194, 154, 104, 1) forState:UIControlStateSelected];
    filterSortBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    filterSortBtn.layer.shadowOffset = CGSizeMake(5, 5);
    filterSortBtn.layer.shadowColor = COLORWITHRGBADIVIDE255(55, 55, 55, 1).CGColor;
    filterSortBtn.layer.shadowOpacity = 0.5;
    filterSortBtn.layer.shadowRadius = btnHeight/2;
    
    CGSize titleSize = [title sc_sizeWithFont:[UIFont systemFontOfSize:12]];
    filterSortBtn.bounds = CGRectMake(0, 0, titleSize.width + 30, btnHeight);
    
    UIView *subView = [[UIView alloc] initWithFrame:filterSortBtn.bounds];
    subView.layer.cornerRadius = btnHeight/2;
    subView.layer.masksToBounds = YES;
    subView.userInteractionEnabled = NO;
    subView.backgroundColor = [UIColor whiteColor];
    [filterSortBtn addSubview:subView];
    [filterSortBtn sendSubviewToBack:subView];
    
    return filterSortBtn;
}

- (void)markTag:(BOOL)marked {
    UIImageView *checkMarkImageView = [self viewWithTag:CheckMarkTag];
    if (checkMarkImageView) {
        [checkMarkImageView removeFromSuperview];
    }
    if (marked) {
        UIImageView *checkImgview = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 20, self.bounds.size.height - 20, 12, 12)];
        checkImgview.tag = CheckMarkTag;
        checkImgview.image = [UIImage imageNamed:@"tag_mark"];
        [self addSubview:checkImgview];
    }
}

@end
