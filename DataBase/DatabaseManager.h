//
//  DatabaseManager.h
//  EDA
//
//  Created by shichuang on 16/10/9.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabaseQueue;
@interface DatabaseManager : NSObject

{
    BOOL _isInitializeSuccess;
    
    BOOL _isDataBaseOpened;
    
    NSString *_writablePath;
    
    FMDatabaseQueue *_databaseQueue;
}

@property (nonatomic, copy) NSString *writablePath;

@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

+ (DatabaseManager*)currentManager;

- (BOOL)isDatabaseOpened;

- (void)openDataBase;

- (void)closeDataBase;


+ (void)releaseManager;

@end
