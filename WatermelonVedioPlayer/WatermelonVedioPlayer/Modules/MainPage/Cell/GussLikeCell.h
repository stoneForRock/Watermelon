//
//  GussLikeCell.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/13.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieCoverView.h"

@protocol GussLikeCellDelegate <NSObject>
@optional
- (void)gussLikeCellClickMovie:(MoivesModel *)moive;
@end

NS_ASSUME_NONNULL_BEGIN

@interface GussLikeCell : UITableViewCell

@property (nonatomic, strong) NSArray *cellDataList;
@property (nonatomic, assign) id<GussLikeCellDelegate> gussLikeCellDelegate;

@end

NS_ASSUME_NONNULL_END
