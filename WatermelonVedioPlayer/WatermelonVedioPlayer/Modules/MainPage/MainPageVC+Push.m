//
//  MainPageVC+Push.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MainPageVC+Push.h"
#import "MoivesClassListVC.h"
#import "MoivesDetialVC.h"

@implementation MainPageVC (Push)

- (void)tapClassItemPushWithCurrentClassId:(NSString *)currentClassId {
    [self pushToMoiveClassListWithSortType:MoivesSortSynthesize topViewSortType:FilterSort layoutType:MoivesList2Type classList:self.allClassMoviesItem.copy currentClassInfo:currentClassId navTitle:nil];
}

- (void)tapMoreNewlestMovieList {
    [self pushToMoiveClassListWithSortType:MoivesSortMostNew topViewSortType:FilterSort layoutType:MoivesList2Type classList:self.allClassMoviesItem.copy currentClassInfo:@"" navTitle:nil];
}

- (void)tapHotPlayMovieList {
    [self pushToMoiveClassListWithSortType:MoivesSortMostPlay topViewSortType:OnlyFilter layoutType:MoivesList1Type classList:self.allClassMoviesItem.copy currentClassInfo:@"" navTitle:@"重磅热播"];
}

- (void)pushToMoiveClassListWithSortType:(MoivesSortType)sortType topViewSortType:(FilterSortType)topSortType layoutType:(MoivesListType)layoutType classList:(NSArray *)classList currentClassInfo:(NSString *)currentClassId navTitle:(NSString *)navTitle {
    MoivesClassListVC *classListVC = [MoivesClassListVC instanceFromXib];
    classListVC.listType = layoutType;
    classListVC.sortType = sortType;
    classListVC.topViewType = topSortType;
    classListVC.classId = currentClassId;
    classListVC.allClassList = classList;
    classListVC.navTitle = navTitle;
    classListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:classListVC animated:YES];
}

- (void)pushToMoiveDetialVCWithMovieInfo:(MoivesModel *)movieModel {
    MoivesDetialVC *moivesDetialVC = [MoivesDetialVC instanceFromXib];
    moivesDetialVC.movieModel = movieModel;
    moivesDetialVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moivesDetialVC animated:YES];
}

@end
