//
//  SpecialTopicMoiveListVC.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/28.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "SpecialTopicMoiveListVC.h"
#import "UIView+Frame.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MoviesClassListCell3.h"
#import "MoivesRequest.h"
#import "HUDHelper.h"
#import "MoivesDetialVC.h"

#define MoviesClassListCell3Identifier  @"MoviesClassListCell3"
@interface SpecialTopicMoiveListVC ()<UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource, MoviesClassListCell3Delegate>

@property (weak, nonatomic) IBOutlet UIImageView *topCoverImgview;
@property (weak, nonatomic) IBOutlet UIImageView *topMaskImgview;
@property (weak, nonatomic) IBOutlet UILabel *topicNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tableList;

@end

@implementation SpecialTopicMoiveListVC
INSTANCE_XIB_M(@"Moives", SpecialTopicMoiveListVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    [self initUI];
    [self requestData];
}

- (void)dealloc {
    self.navigationController.delegate = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI {
    self.navigationController.delegate = self;
    
    [self.topCoverImgview sd_setImageWithURL:[NSURL URLWithString:self.columnModel.navImage]];
    self.topMaskImgview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 500/1000);
    self.topCoverImgview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 500/1000);
    self.topCoverImgview.layer.mask = self.topMaskImgview.layer;
    self.topicNameLabel.text = self.columnModel.name;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MoviesClassListCell3 class]) bundle:nil] forCellReuseIdentifier:MoviesClassListCell3Identifier];
}

- (void)initDataInfo {
    self.tableList = [NSMutableArray arrayWithCapacity:0];
}

- (void)requestData {
    [HUDHelper showHUDLoading:self.view text:@"请稍候..."];
    [MoivesRequest getColumnMoviesWithNavId:self.columnModel.navId finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        [HUDHelper hideHUDView:self.view];
        if (success) {
            [self formartStyleCell3Data:responseObject];
        } else {
            [HUDHelper showHUDText:error.domain duration:1.5];
        }
    }];
}

- (void)formartStyleCell3Data:(NSArray *)data {
    for (int i = 0; i < data.count; i ++) {
        NSDictionary *movieDic = data[i];
        MoivesModel *model = [[MoivesModel alloc] initWithDictionary:movieDic error:nil];
        if (model) {
            if ((i+1)%3 == 1) {
                [self.tableList addObject:[NSArray arrayWithObject:model]];
            } else {
                NSMutableArray *lastArray = [NSMutableArray arrayWithArray:[self.tableList lastObject]];
                [lastArray addObject:model];
                [self.tableList removeLastObject];
                [self.tableList addObject:lastArray.copy];
            }
        }
    }
    [self.tableView reloadData];
    if (self.tableList.count > 0) {
        [self.tableView hideNoDataView];
    } else {
        [self.tableView showNoDataView:@"暂无该系列影片"];
    }
}

#pragma mark - tableDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoviesClassListCell3 *cell = [tableView dequeueReusableCellWithIdentifier:MoviesClassListCell3Identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *cellList = self.tableList[indexPath.row];
    cell.cellList = cellList;
    cell.moviesClassListCell3Delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1.0;
}

- (void)tapMoiveItemAction:(MoivesModel *)movieModel {
    MoivesDetialVC *moivesDetialVC = [MoivesDetialVC instanceFromXib];
    moivesDetialVC.movieModel = movieModel;
    moivesDetialVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moivesDetialVC animated:YES];
}

@end
