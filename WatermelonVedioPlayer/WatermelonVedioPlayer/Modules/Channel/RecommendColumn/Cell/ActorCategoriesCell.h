//
//  ActorCategoriesCell.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/19.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActorCategoriesCellDelegate <NSObject>
@optional

- (void)clickCategories:(NSDictionary *)categoriesInfo;
- (void)moreCategories;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ActorCategoriesCell : UITableViewCell
@property (nonatomic, strong) NSDictionary *cellData;
@property (nonatomic, assign) id<ActorCategoriesCellDelegate> categoriesCellDelegate;
@end

NS_ASSUME_NONNULL_END
