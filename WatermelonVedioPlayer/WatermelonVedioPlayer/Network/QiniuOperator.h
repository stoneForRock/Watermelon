//
//  QiniuOperator.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "BaseRequest.h"
#import "QiniuSDK.h"

#define QiniuAccessKey        @"4uZDaOnhq6uGkME1siQ5lAx_serGV29QvFeZ_blt"
#define QiniuSecretKey        @"2bvOY3m7NvFRzSy2HEVSHEGsQ5OiOvchYzmvbkat"

//七牛文件类型
enum qiNiuFileType{
    qiNiuTypeImage = 1,//图片
    qiNiuTypeVoice = 2,//语音
    qiNiuTypeVideo = 3,//视频
    qiNiuTypeDefault = 4 //其他
};

typedef void (^uploadProgressCallBack)(NSString *key, float percent);
typedef void (^uploadCallBackKey)(NSString *key);

@interface QiniuOperator : BaseRequest

@property    (nonatomic,assign) BOOL            cancelled; //取消上传函数

@property (nonatomic , assign) int expires;//token失效时间,即默认token保存1小时

/**
 *七牛上传获取上传进度方法  bucket为上传到七牛的对应空间
 *                 fileData为需要上传的文件data
 *                 fileType为需要上传的文件类型 （1代表图片  2代表语音  3代表视频 4其他）
 *               fileName为文件名称，和图片路径有关，应该和用户id和图片用处绑定到一起
 *                 callBack为需要上传上传成功回调
 *                 progressCallBack为上传进度回调
 */
-(void)qiuNiuUpWithProgressWithBucket:(NSString    *)bucket
                             fileData:(NSData    *)fileData
                             fileType:(NSString    *)fileType
                             fileName:(NSString *)fileName
                             CallBack:(RequestFinishBlock)callBack
                     ProgressCallBack:(uploadProgressCallBack)progressCallBack
                          KeyCallBack:(uploadCallBackKey)callBackKey;

+(NSString    *)defaultQiNiuUrlWithPath:(NSString    *)path;

+ (NSString *)typeForImageData:(NSData *)data;

@end
