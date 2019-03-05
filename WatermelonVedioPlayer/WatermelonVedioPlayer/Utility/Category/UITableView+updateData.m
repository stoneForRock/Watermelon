//
//  UITableView+updateData.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "UITableView+updateData.h"

@implementation UITableView (updateData)

- (void)insertRowsWithCount:(int)count withRowAnimation:(UITableViewRowAnimation)animation
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (int i = 0; i < count; i++)
    {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadDataAnimated:(void(^)())completion
{
    if (self.dataSource)
    {
        NSRange range = NSMakeRange(0, [self.dataSource numberOfSectionsInTableView:self]);
        NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
        [CATransaction begin];
        [self beginUpdates];
        if (completion)
        {
            [CATransaction setCompletionBlock:completion];
        }
        [self reloadSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];
        [self endUpdates];
        [CATransaction commit];
    }
}

@end
