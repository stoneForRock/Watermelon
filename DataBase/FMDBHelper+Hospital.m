//
//  FMDBHelper+Hospital.m
//  EDA
//
//  Created by 陈逸辰 on 16/11/26.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper+Hospital.h"

@implementation FMDBHelper (Hospital)

#pragma mark - 创建时间标签数据库表
//- (void)createHospitalTableOnDB
//{
//    if([[self getDB] tableExists:DBHospitalList] == NO){
//        NSString *departmentsql = @"CREATE TABLE IF NOT EXISTS %@(\
//        _id INTEGER PRIMARY KEY AUTOINCREMENT,\
//        hospitalId                      text,\
//        name                            text,\
//        lat                             text,\
//        lng                             text,\
//        level                           text,\
//        lat                             text,\
//        city                            INTEGER,\
//        country                         INTEGER,\
//        province                        INTEGER,\
//        UNIQUE(hospitalId))";
//        
//        departmentsql = [NSString stringWithFormat:departmentsql, DBHospitalList];
//        BOOL state = [[self getDB] executeUpdate:departmentsql];
//        if (!state) {
//            DLog(@"error when create dbTable kDBHospitalList");
//        } else {
//            DLog(@"success to create dbTable kDBHospitalList");
//        }
//    }
//}
//
//// 插入录model
//- (void)insertHospital:(HospitalModel *)model
//{
//    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(hospitalId,name,lat,lng,level,lat,city,country,province)VALUES('%@','%@','%@','%@','%@','%@','%d','%d','%d')",DBHospitalList,[model.hospitalId safeForFMDBString],[model.HospitalCompanyId safeForFMDBString],[model.HospitalName safeForFMDBString],[model.HospitalHideType safeForFMDBString],[model.HospitalDesc safeForFMDBString],[model.HospitalSortWeight safeForFMDBString]];
//    BOOL resSqls = [[self getDB] executeUpdate:strSqls];
//    if (!resSqls) {
//        DLog(@"error when insert dbTable kDBHospitalList");
//    } else {
//        DLog(@"success to insert dbTable kDBHospitalList");
//    }
//}
//
////更新数据库数据
//- (void)updateHospital:(HospitalModel *) model
//{
//    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET HospitalCompanyId = '%@', HospitalName = '%@',HospitalHideType = '%@' , HospitalDesc = '%@', HospitalSortWeight = '%@' where HospitalId = '%@'",DBHospitalList,[model.HospitalCompanyId safeForFMDBString],[model.HospitalName safeForFMDBString],[model.HospitalHideType safeForFMDBString],[model.HospitalDesc safeForFMDBString],[model.HospitalSortWeight safeForFMDBString],[model.HospitalId safeForFMDBString]];
//    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
//    if (!resSqls) {
//        DLog(@"error when update dbTable kDBHospitalList");
//    } else {
//        DLog(@"success to update dbTable kDBHospitalList");
//    }
//}
//
////查询数据库中是否存在某个时长标签
//- (BOOL)hasHospital:(NSString *) HospitalId
//{
//    NSString *strSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE HospitalId = '%@'",DBHospitalList,[HospitalId safeForFMDBString]];
//    FMResultSet *res = [[self getDB] executeQuery:strSql];
//    if (!res)
//    {
//        NSLog(@"NO");
//    }
//    
//    NSDictionary *dic = nil;
//    
//    while ([res next])
//    {
//        dic = [res resultDictionary];
//    }
//    
//    if (dic)
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//    
//}
//
////查询所有的时长标签
//- (NSArray *)queryAllHospital
//{
//    NSMutableArray *groupArray = @[].mutableCopy;
//    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE HospitalHideType = '%@'",DBHospitalList,@"1"];
//    FMResultSet *rs = [[self getDB] executeQuery:sql];
//    while ([rs next]) {
//        
//        HospitalModel *model = [[HospitalModel alloc] initWithFMDBSet:rs];
//        [groupArray addObject:model];
//    }
//    return [groupArray copy];
//    
//}
//
////根据时长标签数据查询所有的时长标签
//- (NSArray *)queryHospitalModelWithHospitalNames:(NSArray *) HospitalNames
//{
//    NSMutableArray *condationArray = [NSMutableArray arrayWithCapacity:0];
//    for (NSString *timeString in HospitalNames)
//    {
//        [condationArray addObject:[NSString stringWithFormat:@"'%@'",[timeString safeForFMDBString]]];
//    }
//    
//    NSMutableArray *groupArray = @[].mutableCopy;
//    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE HospitalName in (%@)",DBHospitalList,[condationArray componentsJoinedByString:@","]];
//    
//    FMResultSet *rs = [[self getDB] executeQuery:sql];
//    while ([rs next]) {
//        
//        HospitalModel *model = [[HospitalModel alloc] initWithFMDBSet:rs];
//        [groupArray addObject:model];
//    }
//    
//    return [groupArray copy];
//}
//
////根据标签编码获取时长标签内容
//- (HospitalModel *)queryHospitalModelByHospitalCode:(NSString *) HospitalId
//{
//    NSMutableArray *groupArray = @[].mutableCopy;
//    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE HospitalId =  '%@'",DBHospitalList,[HospitalId safeForFMDBString]];
//    FMResultSet *rs = [[self getDB] executeQuery:sql];
//    while ([rs next]) {
//        
//        HospitalModel *model = [[HospitalModel alloc] initWithFMDBSet:rs];
//        [groupArray addObject:model];
//    }
//    return [groupArray lastObject];
//}


@end
