//
//  ActorTopicCell.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/19.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieCoverView.h"

@protocol ActorTopicCellDelegate <NSObject>
@optional
- (void)actorTopicCellClickMovie:(MoivesModel *)moive;
@end

NS_ASSUME_NONNULL_BEGIN

@interface ActorTopicCell : UITableViewCell

@property (nonatomic, strong) NSArray *cellDataList;
@property (nonatomic, assign) id<ActorTopicCellDelegate> actorTopicCellDelegate;

@end

NS_ASSUME_NONNULL_END
