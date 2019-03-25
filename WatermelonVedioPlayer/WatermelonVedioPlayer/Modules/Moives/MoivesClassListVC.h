//
//  MoivesClassListVC.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoivesRequest.h"
#import "FilterSortView.h"

typedef NS_ENUM(NSInteger,MoivesListType) {
    MoivesList1Type = 0,//一行一个
    MoivesList2Type = 1,//一行两个
    MoivesList3Type = 2//一行三个
};

NS_ASSUME_NONNULL_BEGIN

@interface MoivesClassListVC : UIViewController

@property (nonatomic, assign) MoivesListType listType;//布局类型,一行显示几个
@property (nonatomic, assign) MoivesSortType sortType;//排序类型
@property (nonatomic, assign) FilterSortType topViewType;//顶部筛选视图的样式

@property (nonatomic, strong) NSArray *allClassList;//所有分类
@property (nonatomic, strong) NSString *classId;//当前分类id 如果为空则查询全部
@property (nonatomic, copy) NSString *navTitle;//未设置默认为 @“全部高清影片”

INSTANCE_XIB_H

@end

NS_ASSUME_NONNULL_END
