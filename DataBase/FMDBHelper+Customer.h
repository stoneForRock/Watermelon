//
//  FMDBHelper+Customer.h
//  EDA
//
//  Created by shichuang on 2016/10/28.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//  客户数据库

#import "FMDBHelper.h"
#import "CustomerModel.h"

@interface FMDBHelper (Customer)

#pragma mark - 创建客户数据库表
- (void)createCustomerTableOnDB;

// 插入客户数据
- (void)insertCustomer:(CustomerModel *) model;
// 根据事务传入db,插入客户数据
- (void)insertCustomer:(CustomerModel *)model dataBase:(FMDatabase *)db;

// 查询客户是否同医院科室姓名
- (BOOL)existSameCustomer:(CustomerModel *) model;

//更新数据库数据
- (void)updateCustomer:(CustomerModel *) model;
//根据事务传入db,更新数据库数据
- (void)updateCustomer:(CustomerModel *) model dataBase:(FMDatabase *)db;

//更新RecordId，服务器返回Id替换本地临时Id
- (void)updateCustomerId:(NSString *)newId withOldId:(NSString *)oldId;

//查询数据库中是否存在某个客户
- (BOOL)hasCustomer:(CustomerModel *) model;
//根据事务传入db,查询数据库中是否存在某个客户
- (BOOL)hasCustomer:(CustomerModel *) model dataBase:(FMDatabase *)db;

//根据customerId查询某个客户
- (CustomerModel *)queryCustomerWithCustomerId:(NSString *)customerId;

//根据doctorNum查询某个客户
- (CustomerModel *)queryCustomerWithDoctorNum:(NSString *)doctorNum;

//根据name模糊查询客户
- (NSArray<CustomerModel *> *)queryCustomersWithName:(NSString *)customerName;

//根据tag查询客户
- (NSArray<CustomerModel *> *)queryCustomersByTagName:(NSString *)tagName;

//查询所有医院
- (NSArray<NSString *> *)queryAllHospitalName;

//根据医院查询客户
- (NSArray<CustomerModel *> *)queryCustomersByHospitalName:(NSString *)hospitalName;

// 根据医院和科室名称查询客户
- (NSArray *)queryCustomerWithHospital:(NSString *)hospital andDepartment:(NSString *)department;

//查询所有的客户
- (NSArray<CustomerModel *> *)queryAllCustomer;

//查询所有未上传的客户
- (NSArray<CustomerModel *> *)queryAllUnUploadCustomer;


@end
