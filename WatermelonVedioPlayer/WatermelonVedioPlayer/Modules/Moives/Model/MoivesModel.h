//
//  MoivesModel.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MoivesModel : JSONModel

@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *dislikeCnt;
@property (nonatomic, copy) NSString *file;
@property (nonatomic, copy) NSString *moiveId;
@property (nonatomic, copy) NSString *loveCnt;
@property (nonatomic, copy) NSString *movCls;
@property (nonatomic, copy) NSString *movDesc;
@property (nonatomic, copy) NSString *movName;
@property (nonatomic, copy) NSString *movScore;
@property (nonatomic, copy) NSString *playCount;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *updateTime;


@end

NS_ASSUME_NONNULL_END
