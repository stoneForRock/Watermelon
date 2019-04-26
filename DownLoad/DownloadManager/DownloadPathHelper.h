//
//  DownloadPathHelper.h
//  EDA
//
//  Created by shichuang on 16/10/11.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

// 缓存主目录
#define CACHES_DIRECTORY     [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

// 完整用户文件名称
#define USER            CurrentUser.employeeId

// 下载文件的总文件名称
#define DOWNLOAD            @"EDADownLoad"



// 临时文件夹名称
#define TEMP                @"TempDownLoading"
// 下载原始文件夹名称
#define ZIP                 @"EDAZip"
// 解压后的缓存文件夹名称
#define UNZIP               @"EDAUzip"

#pragma mark ------------------------------应用路径分割线----------------------------------

// 临时文件夹的路径
#define TEMP_FOLDER          [NSString stringWithFormat:@"%@/%@/%@/%@",CACHES_DIRECTORY,USER,DOWNLOAD,TEMP]
// 临时文件的路径
#define TEMP_PATH(name)      [NSString stringWithFormat:@"%@/%@",[DownloadPathHelper createFolder:TEMP_FOLDER],name]

// 下载文件夹路径
#define ZIP_FOLDER          [NSString stringWithFormat:@"%@/%@/%@/%@",CACHES_DIRECTORY,USER,DOWNLOAD,ZIP]
// 下载文件的路径
#define ZIP_PATH(name)      [NSString stringWithFormat:@"%@/%@",[DownloadPathHelper createFolder:ZIP_FOLDER],name]

// 解压后缓存的文件夹路径
#define  UNZIP_FLODER        [NSString stringWithFormat:@"%@/%@/%@/%@",CACHES_DIRECTORY,USER,DOWNLOAD,UNZIP]
// 解压后缓存文件的路径
#define UNZIP_PATH(name)      [NSString stringWithFormat:@"%@/%@",[DownloadPathHelper createFolder:UNZIP_FLODER],name]


// 缩略图文件路径
#define FILE_IMAGE(name)     [NSString stringWithFormat:@"%@/%@.png",UNZIP_PATH(name),name]

// html文件路径
#define FILE_CONTENT(name)   [NSString stringWithFormat:@"%@/index.html",UNZIP_PATH(name)]


@interface DownloadPathHelper : NSObject


+ (NSString *)createFolder:(NSString *)path;

//获取某个路径下文件大小 单位为byte
+ (unsigned long long)fileSizeForPath:(NSString *)path;

//获取手机剩余存储空间的大小  单位为byte
+ (long long) freeDiskSpaceInBytes;

//将单位为byte的大小转化为 kb mb 等单位的字符串，具体单位取决于大小
+ (NSString *)getFileSizeString:(NSString *)size;


//将单位为kb mb 等单位的字符串 转化为byte大小
+ (float)getFileSizeNumber:(NSString *)size;

//遍历文件夹获得文件夹大小，返回多少M
+ (float)folderSizeAtPath:(NSString*) folderPath;

//删除文件夹下的所有文件
+ (void)removeAllFileAtPath:(NSString *) folderPath;

//解压文件
+ (void)unZipFile:(NSString *) fileName callBack:(void(^)(BOOL finish)) block;

//根据离职员工id删除对应缓存的文件
+ (void)deleteCachesFileWithFiredEmployeeIds:(NSArray *) firedEmployeeIds;

//获取目前设备中包含的所有有文件的用户职员id集合
+ (NSArray<NSString *> *)getCurrentDeviceFilePathUsers;


//存储documents里面的文件不需要备份到icloud
+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *) filePathString;


@end
