//
//  EDSLearningSituationViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSLearningSituationViewController.h"
#import "EDSHeaderPageButtonView.h"

@interface EDSLearningSituationViewController ()

@end

@implementation EDSLearningSituationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EDSHeaderPageButtonView *headerView = [[EDSHeaderPageButtonView alloc] init];
    headerView.btnArr = @[@"学习情况",@"考试情况"];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    headerView.headerPageButtonDidSelectStringback = ^(NSString *titleStr) {
        DLog(@"%@",titleStr);
    };
}



@end
