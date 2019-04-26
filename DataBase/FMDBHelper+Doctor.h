//
//  FMDBHelper+Doctor.h
//  EDA
//
//  Created by 陈逸辰 on 16/11/28.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper.h"
#import "DoctorModel.h"

@interface FMDBHelper (Doctor)

#pragma mark - 创建时间标签数据库表
- (void)createDoctorTableOnDB;

// 插入
- (void)insertDoctor:(DoctorModel *) model;

// 更新
- (void)updateDoctor:(DoctorModel *) model;

// 根据医院sourceId和科室Id查询医生
//- (NSArray *)queryDoctorWithHospitalSourceId:(NSString *)hospitalSourceId andDepartmentCode:(NSString *)departmentCode;

// 根据医院和科室名称查询医生
- (NSArray *)queryDoctorWithHospital:(NSString *)hospital andDepartment:(NSString *)department;

// 根据医生名查询
- (NSArray *)queryDoctorWithName:(NSString *)name;


@end
