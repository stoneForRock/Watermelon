//
//  TagFilterView.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/23.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TagFilterViewDelegate <NSObject>
@optional

- (void)tagFilterViewSelectedSupTagInfo:(NSDictionary *)supTagInfo;
- (void)tagFilterViewResetAll;

@end

NS_ASSUME_NONNULL_BEGIN

@interface TagFilterView : UIView

@property (nonatomic, assign) id<TagFilterViewDelegate> tagFilterViewDelegate;

- (instancetype)initWithFrame:(CGRect)frame tagList:(NSArray *)tagList;

- (void)refreshSelectedIds:(NSArray *)selectedIds;

@end

@interface UIButton (tagFilter)

+ (instancetype)buttonWithTagTitle:(NSString *)title btnHeight:(CGFloat)btnHeight;
- (void)markTag:(BOOL)marked;

@end

NS_ASSUME_NONNULL_END


