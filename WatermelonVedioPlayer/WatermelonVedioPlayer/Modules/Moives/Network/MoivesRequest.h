//
//  MoivesRequest.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface MoivesRequest : BaseRequest

/**
 获取电影分类下的列表

 @param sortKey 排序类型：play_count - 最多播放，love_cnt - 最多喜欢，id - 最近更新，为空则为综合排序
 @param classId 影片分类
 @param page 当前页 1开始
 @param finishBlock finishBlock
 */
+ (void)requestMovieListWithSort:(NSString *)sortKey classId:(NSString *)classId page:(NSString *)page finishBlock:(RequestFinishBlock)finishBlock;
@end

NS_ASSUME_NONNULL_END
