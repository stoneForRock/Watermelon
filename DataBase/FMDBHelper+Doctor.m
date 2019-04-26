//
//  FMDBHelper+Doctor.m
//  EDA
//
//  Created by 陈逸辰 on 16/11/28.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper+Doctor.h"

@implementation FMDBHelper (Doctor)

#pragma mark - 创建时间标签数据库表
- (void)createDoctorTableOnDB
{
    if([[self getDB] tableExists:DBDoctorList] == NO){
        NSString *departmentsql = @"CREATE TABLE IF NOT EXISTS %@(\
        _id INTEGER PRIMARY KEY AUTOINCREMENT,\
        doctorId                      text,\
        doctorNum                     text,\
        status                        text,\
        name                          text,\
        title                         text,\
        titleRank                     text,\
        hospital                      text,\
        hospitalId                    text,\
        hospitalSourceId              text,\
        department                    text,\
        deptCode                      text,\
        updatorDate                   text,\
        UNIQUE(doctorId))";
        
        departmentsql = [NSString stringWithFormat:departmentsql, DBDoctorList];
        BOOL state = [[self getDB] executeUpdate:departmentsql];
        if (!state) {
            DLog(@"error when create dbTable kDBDoctorList");
        } else {
            DLog(@"success to create dbTable kDBDoctorList");
        }
    }
}

// 插入录model
- (void)insertDoctor:(DoctorModel *)model
{
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(doctorId,doctorNum,status,name,title,titleRank,hospital,hospitalId,hospitalSourceId,department,deptCode,updatorDate)VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",DBDoctorList,[model.doctorId safeForFMDBString],[model.doctorNum safeForFMDBString],[model.status safeForFMDBString],[model.name safeForFMDBString],[model.title safeForFMDBString],[model.titleRank safeForFMDBString],[model.hospital safeForFMDBString],[model.hospitalId safeForFMDBString],[model.hospitalSourceId safeForFMDBString],[model.department safeForFMDBString],[model.deptCode safeForFMDBString],[model.updatorDate safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBDoctorList");
    } else {
        DLog(@"success to insert dbTable kDBDoctorList");
    }
}

//更新数据库数据
- (void)updateDoctor:(DoctorModel *) model
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET doctorId = '%@', doctorNum = '%@',status = '%@' , name = '%@', title = '%@', titleRank = '%@', hospital = '%@', hospitalId = '%@', hospitalSourceId = '%@', department = '%@', deptCode = '%@', updatorDate = '%@'",DBDoctorList,[model.doctorId safeForFMDBString],[model.doctorNum safeForFMDBString],[model.status safeForFMDBString],[model.name safeForFMDBString],[model.title safeForFMDBString],[model.titleRank safeForFMDBString],[model.hospital safeForFMDBString],[model.hospitalId safeForFMDBString],[model.hospitalSourceId safeForFMDBString],[model.department safeForFMDBString],[model.deptCode safeForFMDBString],[model.updatorDate safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBDoctorList");
    } else {
        DLog(@"success to update dbTable kDBDoctorList");
    }
}

// 根据医院和科室查询医生
- (NSArray *)queryDoctorWithHospitalSourceId:(NSString *)hospitalSourceId andDepartmentCode:(NSString *)departmentCode
{
    NSMutableArray *doctorArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE hospitalSourceId = '%@' AND deptCode = '%@'",DBDoctorList, hospitalSourceId, departmentCode];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        DoctorModel *model = [[DoctorModel alloc] initWithFMDBSet:rs];
        [doctorArray addObject:model];
    }
    return [doctorArray copy];
}

// 根据医院和科室名称查询医生
- (NSArray *)queryDoctorWithHospital:(NSString *)hospital andDepartment:(NSString *)department
{
    NSMutableArray *doctorArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE hospital = '%@' AND department = '%@'",DBDoctorList, hospital, department];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        DoctorModel *model = [[DoctorModel alloc] initWithFMDBSet:rs];
        [doctorArray addObject:model];
    }
    return [doctorArray copy];
}

// 根据医生名查询
- (NSArray *)queryDoctorWithName:(NSString *)name
{
    NSMutableArray *doctorArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE name like '%%%@%%'",DBDoctorList, name];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        DoctorModel *model = [[DoctorModel alloc] initWithFMDBSet:rs];
        [doctorArray addObject:model];
    }
    return [doctorArray copy];
}

@end
