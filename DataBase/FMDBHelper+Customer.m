//
//  FMDBHelper+Customer.m
//  EDA
//
//  Created by shichuang on 2016/10/28.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper+Customer.h"

@implementation FMDBHelper (Customer)

- (void)createCustomerTableOnDB
{

    if([[self getDB] tableExists:DBCustomerList] == NO){
        NSString *departmentsql = @"CREATE TABLE IF NOT EXISTS %@(\
        _id INTEGER PRIMARY KEY AUTOINCREMENT,\
        customerId                      text,\
        customerName                    text,\
        customerDoctorNum               text,\
        customerHospital                text,\
        customerHospitalCode            text,\
        customerDepartment              text,\
        customerDepartmentCode          text,\
        customerTitle                   text,\
        customerTitleRank               text,\
        customerTelephone               text,\
        customerTag                     text,\
        UNIQUE(customerId))";
        
        departmentsql = [NSString stringWithFormat:departmentsql, DBCustomerList];
        BOOL state = [[self getDB] executeUpdate:departmentsql];
        if (!state) {
            DLog(@"error when create dbTable kDBCustomerList");
        } else {
            DLog(@"success to create dbTable kDBCustomerList");
        }
    }
}

// 插入客户数据
- (void)insertCustomer:(CustomerModel *)model
{
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(customerId,customerName,customerDoctorNum,customerHospital,customerHospitalCode,customerDepartment,customerDepartmentCode,customerTitle,customerTitleRank,customerTelephone,customerTag)VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",DBCustomerList,[model.customerId safeForFMDBString],[model.customerName safeForFMDBString],[model.customerDoctorNum safeForFMDBString],[model.customerHospital safeForFMDBString],[model.customerHospitalCode safeForFMDBString],[model.customerDepartment safeForFMDBString],[model.customerDepartmentCode safeForFMDBString],[model.customerTitle safeForFMDBString],[model.customerTitleRank safeForFMDBString],[model.customerTelephone safeForFMDBString],[model.customerTag safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBCustomerList");
    } else {
        DLog(@"success to insert dbTable kDBCustomerList");
    }
}
// 根据事务传入db,插入客户数据
- (void)insertCustomer:(CustomerModel *)model dataBase:(FMDatabase *)db
{
    if (!db) {
        [self insertCustomer:model];
        return;
    }
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(customerId,customerName,customerDoctorNum,customerHospital,customerHospitalCode,customerDepartment,customerDepartmentCode,customerTitle,customerTitleRank,customerTelephone,customerTag)VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",DBCustomerList,[model.customerId safeForFMDBString],[model.customerName safeForFMDBString],[model.customerDoctorNum safeForFMDBString],[model.customerHospital safeForFMDBString],[model.customerHospitalCode safeForFMDBString],[model.customerDepartment safeForFMDBString],[model.customerDepartmentCode safeForFMDBString],[model.customerTitle safeForFMDBString],[model.customerTitleRank safeForFMDBString],[model.customerTelephone safeForFMDBString],[model.customerTag safeForFMDBString]];
    BOOL resSqls = [db executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable kDBCustomerList");
    } else {
        DLog(@"success to insert dbTable kDBCustomerList");
    }
}


// 查询客户是否同医院科室姓名
- (BOOL)existSameCustomer:(CustomerModel *) model
{
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE customerName = '%@' AND customerHospitalCode = '%@' AND customerDepartmentCode = '%@'",DBCustomerList,[model.customerName safeForFMDBString],[model.customerHospitalCode safeForFMDBString],[model.customerDepartmentCode safeForFMDBString]];
    FMResultSet *res = [[self getDB] executeQuery:strSql];
    if (!res)
    {
        NSLog(@"NO");
    }
    
    NSDictionary *dic = nil;
    
    while ([res next])
    {
        dic = [res resultDictionary];
    }
    
    if (dic)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


//更新数据库数据
- (void)updateCustomer:(CustomerModel *) model
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET customerName = '%@', customerDoctorNum = '%@', customerHospital = '%@' , customerDepartment = '%@',customerTitle = '%@' , customerHospitalCode = '%@' , customerDepartmentCode = '%@',customerTitleRank = '%@' , customerTelephone = '%@', customerTag = '%@' where customerId = '%@'",DBCustomerList,[model.customerName safeForFMDBString],[model.customerDoctorNum safeForFMDBString],[model.customerHospital safeForFMDBString],[model.customerDepartment safeForFMDBString],[model.customerTitle safeForFMDBString],[model.customerHospitalCode safeForFMDBString],[model.customerDepartmentCode safeForFMDBString],[model.customerTitleRank safeForFMDBString],[model.customerTelephone safeForFMDBString],[model.customerTag safeForFMDBString],[model.customerId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBCustomerList");
    } else {
        DLog(@"success to update dbTable kDBCustomerList");
    }
}
//根据事务传入db,更新数据库数据
- (void)updateCustomer:(CustomerModel *) model dataBase:(FMDatabase *)db
{
    if (!db) {
        [self updateCustomer:model];
        return;
    }
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET customerName = '%@', customerDoctorNum = '%@', customerHospital = '%@' , customerDepartment = '%@',customerTitle = '%@' , customerHospitalCode = '%@' , customerDepartmentCode = '%@',customerTitleRank = '%@' , customerTelephone = '%@', customerTag = '%@' where customerId = '%@'",DBCustomerList,[model.customerName safeForFMDBString],[model.customerDoctorNum safeForFMDBString],[model.customerHospital safeForFMDBString],[model.customerDepartment safeForFMDBString],[model.customerTitle safeForFMDBString],[model.customerHospitalCode safeForFMDBString],[model.customerDepartmentCode safeForFMDBString],[model.customerTitleRank safeForFMDBString],[model.customerTelephone safeForFMDBString],[model.customerTag safeForFMDBString],[model.customerId safeForFMDBString]];
    BOOL resSqls = [db executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBCustomerList");
    } else {
        DLog(@"success to update dbTable kDBCustomerList");
    }
}


//更新RecordId，服务器返回Id替换本地临时Id
- (void)updateCustomerId:(NSString *)newId withOldId:(NSString *)oldId
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET customerId = '%@' where customerId = '%@'",DBCustomerList,[newId safeForFMDBString],[oldId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable kDBCustomerList");
    } else {
        DLog(@"success to update dbTable kDBCustomerList");
    }
}

//查询数据库中是否存在某个客户
- (BOOL)hasCustomer:(CustomerModel *) model
{
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE customerId = '%@'",DBCustomerList,[model.customerId safeForFMDBString]];
    FMResultSet *res = [[self getDB] executeQuery:strSql];
    if (!res)
    {
        NSLog(@"NO");
    }
    
    NSDictionary *dic = nil;
    
    while ([res next])
    {
        dic = [res resultDictionary];
    }
    
    if (dic)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//根据事务传入db,查询数据库中是否存在某个客户
- (BOOL)hasCustomer:(CustomerModel *) model dataBase:(FMDatabase *)db
{
    if (!db) {
        [self hasCustomer:model];
    }
    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE customerId = '%@'",DBCustomerList,[model.customerId safeForFMDBString]];
    FMResultSet *res = [db executeQuery:strSql];
    if (!res)
    {
        NSLog(@"NO");
    }
    
    NSDictionary *dic = nil;
    
    while ([res next])
    {
        dic = [res resultDictionary];
    }
    
    if (dic)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (CustomerModel *)queryCustomerWithCustomerId:(NSString *)customerId
{
    CustomerModel *model;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where customerId = '%@'",DBCustomerList,[customerId safeForFMDBString]];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        model = [[CustomerModel alloc] initWithFMDBSet:rs];
    }
    return model;
}

//根据doctorId查询某个客户
- (CustomerModel *)queryCustomerWithDoctorNum:(NSString *)doctorNum
{
    CustomerModel *model;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where customerDoctorNum = '%@'",DBCustomerList,[doctorNum safeForFMDBString]];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        model = [[CustomerModel alloc] initWithFMDBSet:rs];
    }
    return model;

}

//根据name模糊查询客户
- (NSArray<CustomerModel *> *)queryCustomersWithName:(NSString *)customerName
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where customerName like '%%%@%%' AND customerDoctorNum = ''",DBCustomerList,[customerName safeForFMDBString]];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    
    while ([rs next]) {
        CustomerModel *model = [[CustomerModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

//根据tag查询客户
- (NSArray<CustomerModel *> *)queryCustomersByTagName:(NSString *)tagName
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where customerTag = '%@'",DBCustomerList,[tagName safeForFMDBString]];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CustomerModel *model = [[CustomerModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

//根据医院查询客户
- (NSArray<CustomerModel *> *)queryCustomersByHospitalName:(NSString *)hospitalName
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE customerHospital = '%@'",DBCustomerList,[hospitalName safeForFMDBString]];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CustomerModel *model = [[CustomerModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

// 根据医院和科室名称查询医生
- (NSArray *)queryCustomerWithHospital:(NSString *)hospital andDepartment:(NSString *)department
{
    NSMutableArray *customerArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE customerDoctorNum = '' AND customerHospital = '%@' AND customerDepartment = '%@'",DBCustomerList, hospital, department];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CustomerModel *model = [[CustomerModel alloc] initWithFMDBSet:rs];
        [customerArray addObject:model];
    }
    return [customerArray copy];
}

//查询所有客户的医院
- (NSArray<NSString *> *)queryAllHospitalName
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT distinct customerHospital FROM %@",DBCustomerList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CustomerModel *model = [[CustomerModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model.customerHospital];
    }
    return [groupArray copy];
}

//查询所有的客户
- (NSArray<CustomerModel *> *)queryAllCustomer
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",DBCustomerList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CustomerModel *model = [[CustomerModel alloc] initWithFMDBSet:rs];
        [groupArray addObject:model];
    }
    return [groupArray copy];
}

//查询所有未上传的客户
- (NSArray<CustomerModel *> *)queryAllUnUploadCustomer
{
    NSMutableArray *groupArray = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",DBCustomerList];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        
        CustomerModel *model = [[CustomerModel alloc] initWithFMDBSet:rs];
        //负值ID未本地产生的ID，未上传到服务器
        if (([model.customerId integerValue] < 0)) {
            [groupArray addObject:model];
        }
    }
    return [groupArray copy];
}

@end
