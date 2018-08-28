//
//  EDSCoachInformationViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCoachInformationViewController.h"

#import "EDSCoachInformationHeaderView.h"
#import "EDSCoachInformationFooterView.h"

@interface EDSCoachInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation EDSCoachInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"教练信息";
    
    UIButton *determineBtn = [[UIButton alloc] init];
    [determineBtn setTitle:@"确认预约" forState:UIControlStateNormal];
    [determineBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    determineBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    determineBtn.backgroundColor = ThemeColor;
    determineBtn.layer.cornerRadius = 5;
    determineBtn.layer.masksToBounds = YES;
    [self.view addSubview:determineBtn];
    [determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(-18);
    }];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = ClearColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(determineBtn.mas_top).mas_equalTo(-15);
    }];
    
    EDSCoachInformationHeaderView *headerView = [[EDSCoachInformationHeaderView alloc] init];
    headerView.wz_size = CGSizeMake(kScreenWidth, 100);
    self.tableView.tableHeaderView = headerView;
    
    
}

#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标示:
    static NSString *ID = @"EDSCoachInformationFooterView";
    // 2.从缓存池中取
    EDSCoachInformationFooterView *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[EDSCoachInformationFooterView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}


@end
