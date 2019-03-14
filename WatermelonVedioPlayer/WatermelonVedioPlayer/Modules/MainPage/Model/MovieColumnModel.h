//
//  MovieColumnModel.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/14.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "JSONModel.h"
#import "MoivesModel.h"
@protocol MoivesModel;
NS_ASSUME_NONNULL_BEGIN

@interface MovieColumnModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *cover;
@property (nonatomic, copy) NSString<Optional> *name;
@property (nonatomic, copy) NSString<Optional> *navId;
@property (nonatomic, copy) NSString<Optional> *navImage;
@property (nonatomic, strong) NSArray<MoivesModel,Optional> *movies;

@end

NS_ASSUME_NONNULL_END
