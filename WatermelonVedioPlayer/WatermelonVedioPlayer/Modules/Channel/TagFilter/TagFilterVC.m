//
//  TagFilterVC.m
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/4/13.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#import "TagFilterVC.h"
#import "ChannelRequest.h"
#import "TagFilterView.h"
#import "SubTagView.h"

@interface TagFilterVC ()<TagFilterViewDelegate>

@property (nonatomic, strong) NSMutableArray *tableList;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *allTagList;
@property (nonatomic, strong) NSMutableArray *allSelectedTagIdList;

@property (nonatomic, strong) TagFilterView *tagFilterView;
@property (nonatomic, strong) SubTagView *subTagView;

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
    self.allTagList = [NSMutableArray arrayWithCapacity:0];
    self.allSelectedTagIdList = [NSMutableArray arrayWithCapacity:0];
}

- (void)initUI {
    
}

- (void)createTagFilterView {
    self.tagFilterView = [[TagFilterView alloc] initWithFrame:CGRectMake(0, SafeTopHeight, ScreenFullWidth, 70) tagList:self.allTagList];
    self.tagFilterView.tagFilterViewDelegate = self;
    [self.view addSubview:self.tagFilterView];
}

- (void)requestData {
    [self requestTags];
}

- (void)requestTags {
    [ChannelRequest getTagListFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        if (success) {
            NSArray *responseArray = responseObject;
            if (responseArray.count > 0) {
                NSMutableDictionary *allTagDic = [NSMutableDictionary dictionaryWithCapacity:0];
                [allTagDic setObject:@"0" forKey:@"pid"];
                [allTagDic setObject:@"全部" forKey:@"pname"];
                NSMutableArray *allTagSubClass = [NSMutableArray arrayWithCapacity:0];
                for (int i = 0; i < responseArray.count; i ++ ) {
                    NSDictionary *tagInfo = responseArray[i];
                    [allTagSubClass addObjectsFromArray:tagInfo[@"subclass"]?tagInfo[@"subclass"]:@[]];
                }
                [allTagDic setObject:allTagSubClass forKey:@"subclass"];
                [self.allTagList addObject:allTagDic];
                [self.allTagList addObjectsFromArray:responseArray];
                [self createTagFilterView];
            }
        }
    }];
}

- (void)requestTagMovies {
    [ChannelRequest queryMovieWithTagIds:@[] page:self.currentPage finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
}

#pragma mark - TagFilterViewDelegate
- (void)tagFilterViewSelectedSupTagInfo:(NSDictionary *)supTagInfo {
    
}

- (void)tagFilterViewResetAll {
    
}

@end
