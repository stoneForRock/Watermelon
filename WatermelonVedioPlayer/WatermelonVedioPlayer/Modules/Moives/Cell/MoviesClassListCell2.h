//
//  MoviesClassListCell2.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/18.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieCoverView.h"

@protocol MoviesClassListCell2Delegate <NSObject>
@optional

- (void)tapMoiveItemAction:(MoivesModel *)movieModel;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MoviesClassListCell2 : UITableViewCell

@property (nonatomic, strong) NSArray *cellList;
@property (nonatomic, assign) id<MoviesClassListCell2Delegate> moviesClassListCell2Delegate;

@end

NS_ASSUME_NONNULL_END
