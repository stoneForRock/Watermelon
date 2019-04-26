//
//  DownloadBaseModel.h
//  EDA
//
//  Created by shichuang on 16/10/11.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DownloadBaseModel;

typedef NS_ENUM(NSInteger,DownLoadState) {
    Downloading,       //下载中
    WillDownload,      //等待下载
    StopDownload,      //停止下载
    DownloadComplete,  //下载完成
    DownloadError,     //下载出错
    DownloadRestart,   //重新开始
    DownloadNone       //未下载
};

typedef void(^DownloadOnProgressBlock)(DownloadBaseModel *downloadModel);

typedef void(^DownloadChangeStateBlock)(DownloadBaseModel *downloadModel);

@interface DownloadBaseModel : NSObject

/** 文件名 */
@property (nonatomic, copy) NSString                    *fileName;

/** 文件id */
@property (nonatomic, copy)  NSString                   *fileId;

/** 文件的总长度 */
@property (nonatomic, copy) NSString                    *fileSize;

/** 文件的类型(文件后缀,比如:mp4)*/
@property (nonatomic, copy) NSString                    *fileType;

/** 文件已下载的长度 */
@property (nonatomic, copy) NSString                    *fileReceivedSize;

/** 下载文件的URL */
@property (nonatomic, copy) NSString                    *fileURL;

/** 下载添加的时间 用来下载队列排序 */
@property (nonatomic, copy) NSString                    *downloadTime;

/** 文件的附属图片 */
@property (nonatomic,strong) UIImage                    *fileimage;

/** 文件的附属图片链接  */
@property (nonatomic, copy) NSString                    *fileImageUrlStr;

/** 当前文件的下载即时速度字符串 */
@property (nonatomic, copy)   NSString                  *speedString;

/** 当前文件的下载进度 */
@property (nonatomic, assign) CGFloat                    downloadProgress;

/** 计算速度需要用到的时间 */
@property (nonatomic, strong) NSDate                    *speedTime;

/** 计算速度需要用到的单位时间(1s)的总下载量  */
@property (nonatomic, assign) NSInteger                  speedTotalBytes;

/** 下载的状态 */
@property (nonatomic, assign) DownLoadState              downloadState;

/** 文件下载进度更新block */
@property (nonatomic, copy) DownloadOnProgressBlock    onProgressing;

/** 文件状态更改更新block */
@property (nonatomic, copy) DownloadChangeStateBlock   stateChanged;

/** 文件下载时的output文件流 */
@property (nonatomic, strong) NSOutputStream            *stream;

/** 文件下载的task 用来暂停*/
@property (nonatomic, strong) NSURLSessionDataTask    *downloadTask;


@end
