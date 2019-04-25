//
//  PlayHistoryManager.h
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/25.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoivesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayHistoryManager : NSObject

+ (PlayHistoryManager *)shared;

- (void)saveMovie:(MoivesModel *)movieModel;
- (NSArray *)readMovies;

@end

NS_ASSUME_NONNULL_END
