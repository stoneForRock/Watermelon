//
//  MoivesClassListVC.m
//  WatermelonVedioPlayer
//
//  Created by dachen on 2019/3/12.
//  Copyright © 2019年 VedioPlayer. All rights reserved.
//

#import "MoivesClassListVC.h"
#import "MoivesRequest.h"

@interface MoivesClassListVC ()

@property (weak, nonatomic) IBOutlet UITableView *tabelView;

@end

@implementation MoivesClassListVC
INSTANCE_XIB_M(@"Moives", MoivesClassListVC)
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
