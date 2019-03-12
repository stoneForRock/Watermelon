//
//  MoiveClassCell.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoiveClassCellDelegate <NSObject>
@optional

- (void)clickMoiveClass:(NSDictionary *)classInfo;

@end
NS_ASSUME_NONNULL_BEGIN

@interface MoiveClassCell : UITableViewCell

@property (nonatomic, strong) NSArray *cellDatas;
@property (nonatomic, assign) id<MoiveClassCellDelegate> moiveClassCellDelegate;

@end

NS_ASSUME_NONNULL_END
