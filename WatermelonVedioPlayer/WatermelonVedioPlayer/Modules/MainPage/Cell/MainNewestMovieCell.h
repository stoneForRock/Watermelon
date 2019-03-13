//
//  MainNewestMovieCell.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainNewestMovieCellDelegate <NSObject>
@optional

- (void)newestMovieCellClickMoive:(NSDictionary *)moiveInfo;
- (void)newestMovieCellMoreAction;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MainNewestMovieCell : UITableViewCell

@property (nonatomic, strong) NSArray *cellDataList;
@property (nonatomic, assign) id<MainNewestMovieCellDelegate> newestMovieCellDelegate;

//设置标题
- (void)showTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
