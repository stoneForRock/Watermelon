//
//  MainPageVC.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoivesModel.h"
#import "MovieColumnModel.h"

@interface MainPageVC : UIViewController

@property (nonatomic, strong) NSMutableDictionary *tableDataSource;

INSTANCE_XIB_H

- (void)initTopScrollWithData:(NSArray *)ads;
- (void)refreshMoiveClassWithClass:(NSArray *)moiveClass;
- (void)refreshNewestMoiveWithList:(NSArray *)newestList;
- (void)refreshHotPlayMoiveWithList:(NSArray *)hotPlayList;
- (void)refreshGussLikeMoiveWithList:(NSArray *)gussLikeList;

- (void)refreshMovieListADWithADList:(NSArray *)adList;
- (void)refreshColumnList:(NSArray *)columnList;

@end
