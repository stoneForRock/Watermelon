//
//  SubTagView.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/24.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubTagViewDelegate <NSObject>
@optional
- (void)subTagViewSelectedTagInfo:(NSDictionary *)tagInfo;
- (void)subTagViewConfirmSelectedTagIds:(NSArray *)allSelectedIds;
@end

NS_ASSUME_NONNULL_BEGIN

@interface SubTagView : UIView
@property (nonatomic, assign) id<SubTagViewDelegate> subTagViewDelegate;
- (void)refreshWithDataList:(NSArray *)dataList selectedIds:(NSArray *)selectedIds;
- (void)refreshSelectedIds:(NSArray *)selectedIds;

@end

@interface TagCollectionCell : UICollectionViewCell
@property (nonatomic, copy) NSString *tagName;
@property (nonatomic, assign) BOOL marked;

@end

NS_ASSUME_NONNULL_END
