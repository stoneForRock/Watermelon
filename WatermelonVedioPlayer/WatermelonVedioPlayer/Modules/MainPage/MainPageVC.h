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
@property (nonatomic, copy) NSString *hotLivePageNum;
@property (nonatomic, copy) NSString *hotLivePages;

//所有的类别项
@property (nonatomic, strong) NSMutableArray *allClassMoviesItem;

INSTANCE_XIB_H

- (void)initTopScrollWithData:(NSArray *)ads;
- (void)refreshMoiveClassWithClass:(NSArray *)moiveClass;
- (void)refreshNewestMoiveWithList:(NSArray *)newestList;
- (void)refreshHotPlayMoiveWithList:(NSArray *)hotPlayList pageNum:(NSString *)pageNum pages:(NSString *)pages;
- (void)refreshGussLikeMoiveWithList:(NSArray *)gussLikeList;

- (void)refreshMovieListADWithADList:(NSArray *)adList;
- (void)refreshColumnList:(NSArray *)columnList;

@end
