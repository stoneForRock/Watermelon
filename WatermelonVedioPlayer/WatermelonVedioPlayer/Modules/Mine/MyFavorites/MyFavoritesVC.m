//
//  MyFavoritesVC.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/4/25.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MyFavoritesVC.h"
#import "MoivesRequest.h"

@interface MyFavoritesVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableList;

@end

@implementation MyFavoritesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    [self initUI];
    [self requestFavoritesList];
}

- (void)initUI {
    self.title = @"我的喜欢";
}

- (void)initDataInfo {
    
}

- (void)requestFavoritesList {
    [MoivesRequest getFavListFinishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        
    }];
}

@end
