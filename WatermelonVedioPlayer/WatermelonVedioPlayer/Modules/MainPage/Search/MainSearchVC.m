//
//  MainSearchVC.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/8.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MainSearchVC.h"
#import "MoivesRequest.h"
#import "HUDHelper.h"
#import "MoivesModel.h"
#import <MJRefresh/MJRefresh.h>
#import "MoviesClassListCell1.h"
#import "MoivesDetialVC.h"
#import "UIImage+getImage.h"
#import "NSString+Tool.h"

#define MoviesClassListCell1Identifier  @"MoviesClassListCell1"
#define kHistoryList  @"HistoryList"

@interface MainSearchVC ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) UIView *navBarView;
@property (nonatomic, strong) UIView *historyView;
@property (nonatomic, strong) UIView *historyKeywordView;
@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, copy) NSString *keyword;
@end

@implementation MainSearchVC

INSTANCE_XIB_M(@"MainPage", MainSearchVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    [self initView];
}

- (void)initView {
    [self initNavView];
    [self initTableView];
    [self initSearchHistoryView];
}

- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenFullWidth, ScreenFullHeight - NavigationBarHeight - StatusBarHeight)];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MoviesClassListCell1 class]) bundle:nil] forCellReuseIdentifier:MoviesClassListCell1Identifier];
}

- (void)initNavView {
        
    self.navBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenFullWidth, 44)];
    self.navigationItem.titleView = self.navBarView;
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(15, 4, ScreenFullWidth - 60, 36)];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"输入关键词查找片源";
    [self.navBarView addSubview:self.searchBar];
    
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:COLORWITHRGBADIVIDE255(30, 30, 30, 1.0)];
        searchField.layer.cornerRadius = 18.0f;
        searchField.layer.masksToBounds = YES;
    }
    
    [self.searchBar becomeFirstResponder];
}

- (void)initSearchHistoryView {
    self.historyView = [[UIView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight + StatusBarHeight, ScreenFullWidth, ScreenFullHeight - NavigationBarHeight - StatusBarHeight)];
    self.historyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.historyView];
    
    UILabel *hisTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, ScreenFullWidth - 70, 30)];
    hisTitleLabel.textColor = COLORWITHRGBADIVIDE255(51, 51, 51, 1);
    hisTitleLabel.text = @"历史搜索";
    hisTitleLabel.font = [UIFont systemFontOfSize:14];
    [self.historyView addSubview:hisTitleLabel];
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    clearBtn.frame = CGRectMake(CGRectGetMaxX(hisTitleLabel.frame) + 10, 40, 30, 30);
    [clearBtn addTarget:self action:@selector(clearAllSearchHistory) forControlEvents:UIControlEventTouchUpInside];
    [self.historyView addSubview:clearBtn];
    
    self.historyKeywordView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(hisTitleLabel.frame), ScreenFullWidth, CGRectGetHeight(self.historyView.frame) - CGRectGetHeight(hisTitleLabel.frame))];
    [self.historyView addSubview:self.historyKeywordView];
    
    [self refreshHistoryKeywordBtn];
}

- (void)refreshHistoryKeywordBtn {
    [self.historyKeywordView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSArray *historyList = [self readSearchHistoryKeyword];
    CGFloat maxBtnX = 0;
    CGFloat maxBtnY = 0;
    for (int i = 0; i < historyList.count; i++) {
        NSString *keyword = historyList[i];
        UIButton *searchKeyBtn = [UIButton buttonWithSearchTypeWithTitle:keyword btnHeight:30];
        if (maxBtnX + 10 + searchKeyBtn.bounds.size.width + 10 > ScreenFullWidth) {
            maxBtnY = maxBtnY + searchKeyBtn.bounds.size.height + 10;
            maxBtnX = 0;
        }
        searchKeyBtn.center = CGPointMake(searchKeyBtn.bounds.size.width/2 + maxBtnX + 10, maxBtnY + 10 + searchKeyBtn.bounds.size.height/2);
        [searchKeyBtn addTarget:self action:@selector(searchKeywordTouch:) forControlEvents:UIControlEventTouchUpInside];
        [self.historyKeywordView addSubview:searchKeyBtn];
        maxBtnX = maxBtnX + 10 + searchKeyBtn.bounds.size.width;
    }
}

- (void)initDataInfo {
    self.currentPage = 1;
    self.resultArray = [NSMutableArray arrayWithCapacity:0];
}

- (void)searchRequest {
    [HUDHelper showHUDLoading:self.view text:@"请稍候..."];
    [MoivesRequest searchMovieWithKeyword:self.keyword currentPage:self.currentPage pageSize:10 finishBlock:^(BOOL success, id  _Nullable responseObject, NSError * _Nullable error) {
        [HUDHelper hideHUDView:self.view];
        [self.tableView.mj_footer endRefreshing];
        if (success) {
            self.historyView.hidden = YES;
            if (self.currentPage == 1) {
                [self.resultArray removeAllObjects];
            }
            NSArray *pageData = responseObject[@"data"];
            if (10 == pageData.count) {
                self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    self.currentPage = self.currentPage+1;
                    [self searchRequest];
                }];
            } else {
                self.tableView.mj_footer = nil;
            }
            for (NSDictionary *movieDic in pageData) {
                MoivesModel *model = [[MoivesModel alloc] initWithDictionary:movieDic error:nil];
                if (model) {
                    [self.resultArray addObject:model];
                }
            }
            [self.tableView reloadData];
            if (self.resultArray.count > 0) {
                [self.tableView hideNoDataView];
            } else {
                [self.tableView showNoDataView:@"暂无该系列影片"];
            }
        } else {
            [HUDHelper showHUDWithErrorText:error.domain inView:self.view];
        }
    }];
}

#pragma mark - btnAction

- (void)clearAllSearchHistory {
    [self clearAllHistoryKeyword];
    [self refreshHistoryKeywordBtn];
}

- (void)searchKeywordTouch:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSString *keyword = sender.titleLabel.text;
    [self searchMovieWithKeyword:keyword];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchMovieWithKeyword:searchBar.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0 || searchText == nil) {
        [self.resultArray removeAllObjects];
        [self.tableView reloadData];
        self.historyView.hidden = NO;
    }
}

- (void)searchMovieWithKeyword:(NSString *)key {
    [self.searchBar resignFirstResponder];
    self.searchBar.text = key;
    [self saveSearchKeyword:key];
    [self refreshHistoryKeywordBtn];
    self.currentPage = 1;
    self.keyword = key;
    [self searchRequest];
}

#pragma mark - tableDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoviesClassListCell1 *cell = [tableView dequeueReusableCellWithIdentifier:MoviesClassListCell1Identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MoivesModel *cellModel = self.resultArray[indexPath.row];
    cell.movieModel = cellModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MoivesModel *cellModel = self.resultArray[indexPath.row];
    MoivesDetialVC *moivesDetialVC = [MoivesDetialVC instanceFromXib];
    moivesDetialVC.movieModel = cellModel;
    moivesDetialVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moivesDetialVC animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}

#pragma mark - save && read
- (void)saveSearchKeyword:(NSString *)keyword {
    NSArray *histroyList = [self readSearchHistoryKeyword];
    NSMutableArray *newHistroyList = [NSMutableArray arrayWithArray:histroyList];
    
    NSPredicate *existPredicate = [NSPredicate predicateWithFormat:@"self = %@",keyword];
    NSArray *filter = [histroyList filteredArrayUsingPredicate:existPredicate];
    if (filter.count > 0) {
        NSString *existKeyword = [filter lastObject];
        NSInteger index = [histroyList indexOfObject:existKeyword];
        [newHistroyList exchangeObjectAtIndex:0 withObjectAtIndex:index];
    } else {
        [newHistroyList insertObject:keyword atIndex:0];
    }
    [[NSUserDefaults standardUserDefaults] setObject:newHistroyList.copy forKey:kHistoryList];
}

- (NSArray *)readSearchHistoryKeyword {
    id historyList = [[NSUserDefaults standardUserDefaults] objectForKey:kHistoryList];
    if ([historyList isKindOfClass:[NSArray class]]) {
        return (NSArray *)historyList;
    } else {
        return @[];
    }
}

- (void)clearAllHistoryKeyword {
    [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:kHistoryList];
}

@end

@implementation UIButton (search)

+ (instancetype)buttonWithSearchTypeWithTitle:(NSString *)title btnHeight:(CGFloat)btnHeight {
    UIButton *filterSortBtn = [self buttonWithType:UIButtonTypeCustom];
    [filterSortBtn setTitle:title forState:UIControlStateNormal];
    [filterSortBtn setTitleColor:COLORWITHRGBADIVIDE255(194, 154, 104, 1) forState:UIControlStateNormal];
    [filterSortBtn setBackgroundImage:[UIImage sc_imageWithColor:COLORWITHRGBADIVIDE255(241, 242, 227, 1)] forState:UIControlStateNormal];
    filterSortBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    filterSortBtn.layer.cornerRadius = btnHeight/2;
    filterSortBtn.layer.masksToBounds = YES;
    
    CGSize titleSize = [title sc_sizeWithFont:[UIFont systemFontOfSize:14]];
    filterSortBtn.bounds = CGRectMake(0, 0, titleSize.width + 30, btnHeight);
    
    return filterSortBtn;
}

@end
