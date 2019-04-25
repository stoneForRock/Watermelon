//
//  PlayHistoryManager.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/25.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "PlayHistoryManager.h"
static PlayHistoryManager *sharedPlayHistoryManager_ = nil;

@interface PlayHistoryManager ()

@property (nonatomic, strong) NSMutableArray *allHistoryList;

@end

@implementation PlayHistoryManager

+ (PlayHistoryManager *)shared {
    @synchronized([PlayHistoryManager class]){
        if(sharedPlayHistoryManager_ == nil) {
            sharedPlayHistoryManager_ = [[PlayHistoryManager alloc] init];
        }
    }
    return sharedPlayHistoryManager_;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.allHistoryList = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)saveMovie:(MoivesModel *)movieModel {
    self.allHistoryList = [NSMutableArray arrayWithArray:[self readMovies]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.moiveId = %@",movieModel.moiveId];
    NSArray *filterArray = [self.allHistoryList filteredArrayUsingPredicate:predicate];
    if (filterArray.count > 0) {
        [self.allHistoryList exchangeObjectAtIndex:0 withObjectAtIndex:[self.allHistoryList indexOfObject:[filterArray lastObject]]];
    } else {
        [self.allHistoryList addObject:movieModel];
    }
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.allHistoryList.copy forKey:@"movieModels"];
    [archiver finishEncoding];
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"historyMovies"];
    [data writeToFile:file atomically:YES];
}

- (NSArray *)readMovies {
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"historyMovies"];
    NSData *data = [NSData dataWithContentsOfFile:file];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSArray *models = [unarchiver decodeObjectForKey:@"movieModels"];
    [unarchiver finishDecoding];
    if (!models) {
        models = @[];
    }
    return models;
}

@end
