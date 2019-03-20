//
//  MoivesClassListVC.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MoivesClassListVC.h"
#import "MoivesRequest.h"

#import "MoviesClassListCell1.h"
#import "MoviesClassListCell2.h"
#import "MoviesClassListCell3.h"

#define MoviesClassListCell1Identifier  @"MoviesClassListCell1"
#define MoviesClassListCell2Identifier  @"MoviesClassListCell2"
#define MoviesClassListCell3Identifier  @"MoviesClassListCell3"

@interface MoivesClassListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@property (nonatomic, strong) NSMutableArray *tableList;

@end

@implementation MoivesClassListVC
INSTANCE_XIB_M(@"Moives", MoivesClassListVC)
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    
    [self initUI];
    
    [self requestData];
}

- (void)initDataInfo {
    
}

- (void)initUI {
    
}

- (void)registTableCell {
    
}

- (void)requestData {
    
}

#pragma mark - tableDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MoviesClassListCell1Identifier];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
