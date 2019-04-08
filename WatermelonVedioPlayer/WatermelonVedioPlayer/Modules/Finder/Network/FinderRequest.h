//
//  FinderRequest.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/8.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface FinderRequest : BaseRequest

/**
 获取发现列表

 @param page 页码，第一次请求不用传
 @param finishBlock finishBlock
 */
+ (void)requestDiscoverListWithPage:(NSInteger)page finishBlock:(RequestFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
