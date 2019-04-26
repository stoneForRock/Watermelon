//
//  FMDBHelper+feedbackStudy.m
//  EDA
//
//  Created by 缪源 on 2017/3/20.
//  Copyright © 2017年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper+feedbackStudy.h"

@implementation FMDBHelper (feedbackStudy)
- (void)createfeedBackStudyTableOnDB
{
    if([[self getDB] tableExists:DBStudyFeedBackList] == NO){
        NSString *feedbacksql = @"CREATE TABLE IF NOT EXISTS %@(\
        _id INTEGER PRIMARY KEY AUTOINCREMENT,\
        slideId                         text,\
        slideVersion                     INTEGER,\
        slideName                        text,\
        pageId                          text,\
        pageName                         text,\
        materialId                      text,\
        studyUserId                      INTEGER,\
        studyOrgId                      text,\
        studyTreePath                   text,\
        studyUserName                    text,\
        studyDate                      long,\
        msg                             text,\
        hasUpload                       INTEGER,\
        UNIQUE(pageId))";
        
        feedbacksql = [NSString stringWithFormat:feedbacksql, DBStudyFeedBackList];
        BOOL state = [[self getDB] executeUpdate:feedbacksql];
        if (!state) {
            DLog(@"error when create dbTable DBStudyFeedBackList");
        } else {
            DLog(@"success to create dbTable DBStudyFeedBackList");
        }
    }
}
//插入数据
- (void)insertFeedbackMsgRecord:(FeedBackModel *)feedbackModel {
    NSString *strSqls = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(slideId,slideVersion,slideName,pageId,pageName,materialId,studyUserId,studyOrgId,studyTreePath,studyUserName,studyDate,msg,hasUpload)VALUES('%@','%ld','%@','%@','%@','%@','%ld','%@','%@','%@','%ld','%@','%d')",DBStudyFeedBackList,[feedbackModel.slideId safeForFMDBString],feedbackModel.slideVersion,[feedbackModel.slideName safeForFMDBString],[feedbackModel.pageId safeForFMDBString],[feedbackModel.pageName safeForFMDBString],[feedbackModel.materialId safeForFMDBString],feedbackModel.studyUserId,[feedbackModel.studyOrgId safeForFMDBString],[feedbackModel.studyTreePath safeForFMDBString],[feedbackModel.studyUserName safeForFMDBString],feedbackModel.studyDate,[feedbackModel.msg safeForFMDBString],feedbackModel.hasUpload];
    BOOL resSqls = [[self getDB] executeUpdate:strSqls];
    if (!resSqls) {
        DLog(@"error when insert dbTable DBStudyFeedBackList");
    } else {
        DLog(@"success to insert dbTable DBStudyFeedBackList");
    }
}

//查询改da的所有数据
- (NSArray <FeedBackModel *>*)queryFeedbackMsgWithSlideId:(NSString *)slideId {
    NSMutableArray *slideArray = [NSMutableArray array];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where slideId = '%@'",DBStudyFeedBackList, [slideId safeForFMDBString]];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        FeedBackModel *model = [[FeedBackModel alloc]initWithFMDBSet:rs];
        [slideArray addObject:model];
    }
    
    return slideArray.copy;
}



//查询单个da页面的数据
- (FeedBackModel *)queryFeedbackMsgModelWithPageId:(NSString *)pageId {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where pageId = '%@'", DBStudyFeedBackList, [pageId safeForFMDBString]];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        FeedBackModel *model = [[FeedBackModel alloc]initWithFMDBSet:rs];
        return model;
    }
    return nil;
}

//查找所有未上传的model
- (NSArray<FeedBackModel *> *)queryAllUnUploadFeedbacks {
    NSMutableArray *feedbackArr = @[].mutableCopy;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where hasUpload = '%d'", DBStudyFeedBackList, 0];
    FMResultSet *rs = [[self getDB] executeQuery:sql];
    while ([rs next]) {
        FeedBackModel *model = [[FeedBackModel alloc]initWithFMDBSet:rs];
        [feedbackArr addObject:model];
    }
    return feedbackArr.copy;
}

//上传成功后更新hasUpload
- (void)updateFeedbackHasUpload:(FeedBackModel *)model
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET hasUpload = '%d' where pageId = '%@'",DBStudyFeedBackList, model.hasUpload, [model.pageId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable DBStudyFeedBackList");
    } else {
        DLog(@"success to update dbTable DBStudyFeedBackList");
    }
}

//更新此页数据
- (void)updateFeedbackPage:(FeedBackModel *)model
{
    NSString *strSQL = [NSString stringWithFormat:@"UPDATE %@ SET studyDate = %ld, msg = %@ where pageId = '%@'",DBStudyFeedBackList, model.studyDate, [model.msg safeForFMDBString] ,[model.pageId safeForFMDBString]];
    BOOL resSqls = [[self getDB] executeUpdate:strSQL];
    if (!resSqls) {
        DLog(@"error when update dbTable DBStudyFeedBackList");
    } else {
        DLog(@"success to update dbTable DBStudyFeedBackList");
    }
}


@end
