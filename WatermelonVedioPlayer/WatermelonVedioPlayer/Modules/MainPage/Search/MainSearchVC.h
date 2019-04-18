//
//  MainSearchVC.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/8.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainSearchVC : UIViewController

INSTANCE_XIB_H

@end

@interface UIButton (search)

+ (instancetype)buttonWithSearchTypeWithTitle:(NSString *)title btnHeight:(CGFloat)btnHeight;

@end

NS_ASSUME_NONNULL_END
