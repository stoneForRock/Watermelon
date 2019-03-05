//
//  UITableView+updateData.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (updateData)

- (void)insertRowsWithCount:(int)count withRowAnimation:(UITableViewRowAnimation)animation;
- (void)reloadDataAnimated:(void(^)())completion; // if you only have section 0 in use

@end
