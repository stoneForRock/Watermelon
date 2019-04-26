//
//  FMDBHelper.h
//  EDA
//
//  Created by shichuang on 16/10/9.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import <FMDatabaseAdditions.h>
#import <FMDatabaseQueue.h>

//下载文件表
#define kDBTableDownLoadFileList           @"tb_DBDownLoadFileList"

//更新文件表
#define kDBTableUpdateFileList            @"tb_DBTableUpdateFileList"

//文件夹目录表
#define DBFileFolderList                  @"tb_DBFileFolderList"

//场景标签表
#define DBSceneTagList                    @"tb_DBSceneTagList"

//时间标签表
#define DBTimeTagList                     @"tb_DBTimeTagList"

//用户自定义DA标签表
#define DBCoustomTagList                  @"tb_DBCoustomTagList"

//客户标签表
#define DBCustomerTagList                 @"tb_DBCustomerTagList"

//客户表
#define DBCustomerList                    @"tb_DBCustomerList"

//演示记录表
#define DBDisplayRecordList               @"tb_DBDisplayRecordList"

//客户记录表
#define DBCustomerRecordsList             @"tb_DBCustomerRecordsList"

//品种组表
#define DBGoodGroupList                   @"tb_DBGoodGroupList"

//医院表
#define DBHospitalList                    @"tb_DBHospitalList"

//科室表
#define DBDepartmentList                  @"tb_DBDepartmentList"

//职称表
#define DBTitleList                       @"tb_DBTitleList"

//品种医院关系表
#define DBGoodGroupHospitalList           @"tb_DBGoodGroupHospitalList"

//医生表
#define DBDoctorList                      @"tb_DBDoctorList"

#define DBStudyFeedBackList               @"tb_DBStudyFeedBackList"

const static double EDADB_VER = 1.0;

@interface FMDBHelper : NSObject
{
@protected FMDatabaseQueue *_databaseQueue;
}

//数据库操作线程
@property (nonatomic, strong) dispatch_queue_t dbHelperQueue;

@property (nonatomic, strong) FMDatabaseQueue   *databaseQueue;

+ (instancetype)defaultDBHelper;

//切换用户的时候改Queue
- (void)changeDBQueue;

#pragma mark - 数据库升级

- (void)ConfigDBManagerVersion;

- (FMDatabase *)getDB;
- (void)createDataBase;

- (void)createTableOnDB;

//清除数据库中的用户资料数据清除内容为当前用户的所有用户数据，包括下载的DA数据、目录图片数据、演示数据、备注数据、标签数据、行为数据、统计数据等
- (void)deleteUserDataSource;


//根据离职的用户职员ids 删除数据库
+ (void)deleteFiredEmployeeTable:(NSArray *) firedEmployeeIds;

//通过查询所有数据库中的表名返回所有登陆过的用户职员ids
+ (NSArray<NSString *> *)getAllEmployee;

@end
