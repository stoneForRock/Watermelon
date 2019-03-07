//
//  LoginRequest.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/18.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "BaseRequest.h"

@interface LoginRequest : BaseRequest

/**
 获取游客token

 @param uiid uiid
 @param finishBlock finishBlock
 */
+ (void)getVisitorTokenWithDeviceUIID:(NSString *)uiid finishBlock:(RequestFinishBlock)finishBlock;

@end
