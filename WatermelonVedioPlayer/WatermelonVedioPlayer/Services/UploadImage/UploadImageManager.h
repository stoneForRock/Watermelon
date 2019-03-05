//
//  UploadImageManager.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/18.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UploadImageComplete)(BOOL success,NSString *imageUrl,NSString *errorMsg);

@interface UploadImageManager : NSObject

+ (UploadImageManager *)shared;

- (void)uploadImageWithQiniuSpace:(NSString *)space
                            image:(UIImage *)image
              uploadImageComplete:(UploadImageComplete)uploadImageComplete;

@end
