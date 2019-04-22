//
//  ColumnNavsCell.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/22.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColumnNavsCellDelegate <NSObject>
@optional
- (void)columnNavsCellClick:(NSDictionary *)navInfo;
@end

NS_ASSUME_NONNULL_BEGIN

@interface ColumnNavsCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *columnNavsInfo;
@property (nonatomic, assign) id<ColumnNavsCellDelegate> columnNavsCellDelegate;

@end

NS_ASSUME_NONNULL_END
