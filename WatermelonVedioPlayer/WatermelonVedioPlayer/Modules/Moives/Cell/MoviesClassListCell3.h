//
//  MoviesClassListCell3.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/18.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieCoverView.h"

@protocol MoviesClassListCell3Delegate <NSObject>
@optional

- (void)tapMoiveItemAction:(MoivesModel *)movieModel;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MoviesClassListCell3 : UITableViewCell

@property (nonatomic, strong) NSArray *cellList;
@property (nonatomic, assign) id<MoviesClassListCell3Delegate> moviesClassListCell3Delegate;

@end

NS_ASSUME_NONNULL_END
