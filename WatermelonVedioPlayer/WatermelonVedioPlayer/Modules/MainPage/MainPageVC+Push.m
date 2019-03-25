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

- (void)pushToMoiveClassListVCWithClassList:(NSArray *)classList currentClassInfo:(NSDictionary *)currentClassInfo {
    
}


/**
 点击分类Item进入列表

 @param sortType 排序类型
 @param classList 所有的类别
 @param currentClassId 当前类别id
 */
- (void)tapClassItemPushWithSortType:(MoivesSortType)sortType classList:(NSArray *)classList currentClassInfo:(NSString *)currentClassId {
    [self pushToMoiveClassListWithSortType:sortType topViewSortType:FilterSort layoutType:MoivesList2Type classList:classList currentClassInfo:currentClassId navTitle:nil];
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
