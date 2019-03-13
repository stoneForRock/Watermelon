//
//  HotPlayCell.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/13.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HotPlayCellDelegate <NSObject>
@optional

- (void)hotPlayCellMoreAction;
- (void)hotPlayCellExchangeAction;
- (void)hotPlayCellClickMovie:(NSDictionary *)movieInfo;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HotPlayCell : UITableViewCell

@property (nonatomic, strong) NSArray *cellDataList;
@property (nonatomic, assign) id<HotPlayCellDelegate> hotPlayCellDelegate;

@end

NS_ASSUME_NONNULL_END
