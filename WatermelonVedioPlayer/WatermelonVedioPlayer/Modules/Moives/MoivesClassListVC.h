//
//  MoivesClassListVC.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MoivesListType) {
    MoivesList1Type = 0,//一行一个
    MoivesList2Type = 1,//一行两个
    MoivesList3Type = 2//一行三个
};

NS_ASSUME_NONNULL_BEGIN

@interface MoivesClassListVC : UIViewController

@property (nonatomic, strong) NSArray *allClassList;//所有分类
@property (nonatomic, strong) NSDictionary *currentClassInfo;//当前选中分类

INSTANCE_XIB_H

@end

NS_ASSUME_NONNULL_END
