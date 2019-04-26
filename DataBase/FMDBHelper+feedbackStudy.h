//
//  FMDBHelper+feedbackStudy.h
//  EDA
//
//  Created by 缪源 on 2017/3/20.
//  Copyright © 2017年 Dachen Tech. All rights reserved.
//

#import "FMDBHelper.h"
#import "FeedBackModel.h"

@interface FMDBHelper (feedbackStudy)

#pragma mark - 创建学习模式下数据库反馈表
- (void)createfeedBackStudyTableOnDB;
//插入反馈记录
- (void)insertFeedbackMsgRecord:(FeedBackModel *)feedbackModel;
//更加slideId查询对应模型记录
- (NSArray <FeedBackModel *>*)queryFeedbackMsgWithSlideId:(NSString *)customerId;

//查询单个da的数据
- (FeedBackModel *)queryFeedbackMsgModelWithPageId:(NSString *)pageId;
//查询所有未上传的记录
- (NSArray<FeedBackModel *> *)queryAllUnUploadFeedbacks;
//上传操作后更新flag
- (void)updateFeedbackHasUpload:(FeedBackModel *)model;
//上传成功后更新hasUpload
- (void)updateFeedbackPage:(FeedBackModel *)model;
@end
