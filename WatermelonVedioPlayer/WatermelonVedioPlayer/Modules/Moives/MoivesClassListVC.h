//
//  MoivesClassListVC.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoivesClassListVC : UIViewController

@property (nonatomic, strong) NSArray *allClassList;//所有分类
@property (nonatomic, strong) NSDictionary *currentClassInfo;//当前选中分类

INSTANCE_XIB_H

@end

NS_ASSUME_NONNULL_END
