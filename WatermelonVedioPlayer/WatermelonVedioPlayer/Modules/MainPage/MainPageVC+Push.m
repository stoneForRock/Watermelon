//
//  MainPageVC+Push.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MainPageVC+Push.h"
#import "MoivesClassListVC.h"

@implementation MainPageVC (Push)

- (void)pushToMoiveClassListVCWithClassList:(NSArray *)classList currentClassInfo:(NSDictionary *)currentClassInfo {
    MoivesClassListVC *classListVC = [MoivesClassListVC instanceFromXib];
    classListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:classListVC animated:YES];
}

@end
