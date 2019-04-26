//
//  FMDBHelper.m
//  EDA
//
//  Created by shichuang on 16/10/9.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper.h"
#import <FMDB/FMDB.h>
#import "DatabaseManager.h"
#import "HYUtility.h"

#import "FMDBHelper+CloudData.h"
#import "FMDBHelper+UpdateDA.h"

#import "FMDBHelper+FolderTree.h"
#import "FMDBHelper+SceneTag.h"
#import "FMDBHelper+TimeTag.h"
#import "FMDBHelper+CoustomDATag.h"

#import "FMDBHelper+CustomerTag.h"
#import "FMDBHelper+Customer.h"

#import "FMDBHelper+DisplayRecord.h"
#import "FMDBHelper+CustomerRecords.h"
#import "FMDBHelper+Doctor.h"
#import "FMDBHelper+feedbackStudy.h"

static FMDatabase *fmdb = nil;

@implementation FMDBHelper
@synthesize databaseQueue = _databaseQueue;

- (id)init{
    self = [super init];
    
    if(self)
    {
        self.databaseQueue = [DatabaseManager currentManager].databaseQueue;
        if (!self.dbHelperQueue) {
            self.dbHelperQueue = dispatch_queue_create("com.dachen.gcd.DBQueue", DISPATCH_QUEUE_CONCURRENT);
        }
        
    }
    
    return self;
}

+ (instancetype)defaultDBHelper
{
    static FMDBHelper *dbHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (dbHelper == nil) {
            dbHelper = [[self alloc] init];
        }
    });
    return dbHelper;
}

//切换用户的时候改Queue
- (void)changeDBQueue
{
    self.databaseQueue = [DatabaseManager currentManager].databaseQueue;
}

#pragma mark - 数据库升级

- (void)ConfigDBManagerVersion
{
    // 创建表
    [self createTableOnDB];
    
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"EDADB_VER"];
    if([oldVersion doubleValue] >= EDADB_VER) return;
    
    if(oldVersion != nil){
        NSString *d = [NSString stringWithFormat:@"%@",oldVersion];
        [self upgrade:[d doubleValue]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:@(EDADB_VER) forKey:@"EDADB_VER"];
}

- (void)upgrade:(double)oldVersion {
    
    if(oldVersion > EDADB_VER) return;
    NSString *d = [NSString stringWithFormat:@"%0.1f",oldVersion+0.1];
    oldVersion = [d doubleValue];
    if(oldVersion == 0.9)//添加status字段
    {
        NSString *modify = [NSString stringWithFormat:@"alter table %@ add status int not null default 0 ",kDBTableDownLoadFileList];
        [[self getDB] executeUpdate:modify];
    }
    else if(oldVersion == 0.9)//添加status字段
    {
        NSString *modify = [NSString stringWithFormat:@"alter table %@ add status int not null default 0 ",kDBTableDownLoadFileList];
        [[self getDB] executeUpdate:modify];
    }
    
    oldVersion += 0.1;
    // 递归判断是否需要升级
    [self upgrade:oldVersion];
}


- (void)createDataBase
{
    
    //更换数据库路径
    NSString *dbPath = [HYUtility filepathAtDocOrRes:@"DataBase"];
    dbPath = [NSString stringWithFormat:@"%@/%@",dbPath,kDBDefaultName];
    
    [DatabaseManager currentManager].writablePath = dbPath;
    [[DatabaseManager currentManager] openDataBase];
    
    fmdb = [[FMDatabase alloc] initWithPath:dbPath];
    [fmdb open];
    
    [self changeDBQueue];
    
    NSString *VersionNum = [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(![HYUtility targetExist:dbPath])
    {
        [HYUtility deleteTargetAtPath:dbPath];
        
        [defaults setObject:VersionNum forKey:@"VersionNum"];
        [defaults synchronize];
    }
}

- (FMDatabaseQueue *)databaseQueue
{
    if (![[DatabaseManager currentManager] isDatabaseOpened]) {
        [[DatabaseManager currentManager] openDataBase];
        self.databaseQueue = [DatabaseManager currentManager].databaseQueue;
        if (_databaseQueue)  [self createTableOnDB];
    }
    return _databaseQueue;
}

// 这是是从沙盒里读取数据库文件
-(FMDatabase *)getDB
{
    if(!fmdb)
    {
        //[DBOperate  databasePath]
        NSString *dbPath = [HYUtility filepathAtDocOrRes:[NSString stringWithFormat:@"DataBase/%@",kDBDefaultName]];
        //判断是否存在数据库文件
        fmdb = [[FMDatabase alloc] initWithPath:dbPath];
        [fmdb open];
    }
    
    return fmdb;
}

- (void)createTableOnDB
{
    [self createDownLoadFileTableOnDB];
    [self createUpdateFileTableOnDB];
    
    [self createFileFolderTreeTableOnDB];
    [self createSceneTagTableOnDB];
    [self createTimeTagTableOnDB];
    [self createCoustomTagTableOnDB];
    
    [self createCustomerTableOnDB];
    [self createCustomerTagTableOnDB];
    
    [self createDisplayRecordTableOnDB];
    [self createCustomerRecordsTableOnDB];
    
    [self createDoctorTableOnDB];
    
    [self createfeedBackStudyTableOnDB];
    
    YTKKeyValueStore *store = [DataStoreHelper storeWithEmployee];
    [store createTableWithName:DBHospitalList];
    [store createTableWithName:DBGoodGroupList];
    [store createTableWithName:DBGoodGroupHospitalList];
    [store createTableWithName:DBDepartmentList];
    [store createTableWithName:DBTitleList];
}


//清除数据库中的用户资料数据清除内容为当前用户的所有用户数据，包括下载的DA数据
- (void)deleteUserDataSource
{
    //删除DA数据
    [self deleteAllCloudData];
    
    //删除更新数据
    [self deleteAllUpdateCloudData];
}

//根据离职的用户职员ids 删除数据库中的表
+ (void)deleteFiredEmployeeTable:(NSArray *) firedEmployeeIds
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    for (NSString *employeeId in firedEmployeeIds)
    {
        NSString *dbPath = [HYUtility filepathAtDocOrRes:[NSString stringWithFormat:@"DataBase/EDAsq_%@.db",employeeId]];
        
        [fileManager removeItemAtPath:dbPath error:NULL];
    }
}

//通过查询所有数据库中的库名返回所有登陆过的用户职员ids
+ (NSArray<NSString *> *)getAllEmployee
{
    NSString *dbPath = [HYUtility filepathAtDocOrRes:@"DataBase"];
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:dbPath]) return @[];
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:dbPath] objectEnumerator];
    
    NSString* fileName;
    
    NSMutableArray *employeeIds = @[].mutableCopy;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil)
    {
        if (fileName.length > 0)
        {
            if (![fileName isEqualToString:@"EDA_user.db"] && ![fileName isEqualToString:@"EDAsq_(null).db"]) {
                [employeeIds addObject:[[[fileName componentsSeparatedByString:@"_"] lastObject] componentsSeparatedByString:@"."][0]];
            }
            
        }
    }
    
    return employeeIds.copy;

}



@end
