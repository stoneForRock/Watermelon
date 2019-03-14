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

@property (nonatomic, copy) NSString<Optional> *cover;
@property (nonatomic, copy) NSString<Optional> *createTime;
@property (nonatomic, copy) NSString<Optional> *dislikeCnt;
@property (nonatomic, copy) NSString<Optional> *file;
@property (nonatomic, copy) NSString<Optional> *moiveId;
@property (nonatomic, copy) NSString<Optional> *loveCnt;
@property (nonatomic, copy) NSString<Optional> *movCls;
@property (nonatomic, copy) NSString<Optional> *movDesc;
@property (nonatomic, copy) NSString<Optional> *movName;
@property (nonatomic, copy) NSString<Optional> *movScore;
@property (nonatomic, copy) NSString<Optional> *playCount;
@property (nonatomic, copy) NSString<Optional> *status;
@property (nonatomic, copy) NSString<Optional> *updateTime;


@end

NS_ASSUME_NONNULL_END
