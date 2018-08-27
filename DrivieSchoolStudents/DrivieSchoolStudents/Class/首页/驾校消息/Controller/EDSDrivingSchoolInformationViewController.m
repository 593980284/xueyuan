//
//  EDSDrivingSchoolInformationViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSDrivingSchoolInformationViewController.h"

#import "EDSDriveSchollInfomationSearchView.h"
#import "EDSDriveSchollInfomationHeaderView.h"

#import "HomeConstants.h"

@interface EDSDrivingSchoolInformationViewController ()

@end

@implementation EDSDrivingSchoolInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EDSDriveSchollInfomationSearchView *searchView = [[EDSDriveSchollInfomationSearchView alloc] initWithFrame:CGRectMake(45, 27, 300, 30)];
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = 5;
    searchView.layer.borderColor = SeparatorCOLOR.CGColor;
    searchView.layer.borderWidth = 0.5;
    self.navigationItem.titleView = searchView;
    
    EDSDriveSchollInfomationHeaderView *headerView = [[EDSDriveSchollInfomationHeaderView alloc] init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(EDSDrivingSchoolInformationHeaderH);
    }];
}



@end
