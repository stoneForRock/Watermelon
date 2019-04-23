//
//  TagFilterVC.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/4/13.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "TagFilterVC.h"
#import "ChannelRequest.h"

@interface TagFilterVC ()

@property (nonatomic, strong) NSMutableArray *tableList;
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation TagFilterVC
INSTANCE_XIB_M(@"Channel", TagFilterVC)
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    [self initUI];
    [self requestData];

}

- (void)initDataInfo {
    self.currentPage = 1;
    self.tableList = [NSMutableArray arrayWithCapacity:0];
}

- (void)initUI {
    
}

- (void)requestData {
    [self requestTags];
    [self requestTagMovies];
}

- (void)requestTags {
    [ChannelRequest getTagListFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
}

- (void)requestTagMovies {
    [ChannelRequest queryMovieWithTagIds:@[] page:self.currentPage finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
}


@end
