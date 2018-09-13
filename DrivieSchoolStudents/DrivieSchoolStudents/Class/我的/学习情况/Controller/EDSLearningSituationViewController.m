//
//  EDSLearningSituationViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSLearningSituationViewController.h"

#import "EDSHeaderPageButtonView.h"
#import "EDSLearningSituationView.h"
#import "EDSTestCaseView.h"

@interface EDSLearningSituationViewController ()

@end

@implementation EDSLearningSituationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"学习";
    
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
    
    
    EDSTestCaseView *learningSituationView = [[EDSTestCaseView alloc] init];
    [self.view addSubview:learningSituationView];
    [learningSituationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(190);
        make.top.mas_equalTo(headerView.mas_bottom);
    }];
    
}



@end
