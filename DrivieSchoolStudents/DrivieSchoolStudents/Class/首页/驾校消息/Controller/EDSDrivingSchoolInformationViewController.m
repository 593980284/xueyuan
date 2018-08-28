//
//  EDSDrivingSchoolInformationViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSDrivingSchoolInformationViewController.h"
#import "EDSDrivingDetailsViewController.h"//驾校详情

#import "EDSDriveSchollInfomationSearchView.h"
#import "EDSDriveSchollInfomationHeaderView.h"
#import "EDSHomeTableViewCell.h"

#import "HomeConstants.h"

@interface EDSDrivingSchoolInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation EDSDrivingSchoolInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addHeaderView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(EDSDrivingSchoolInformationHeaderH);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)addHeaderView
{
    
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


#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return EDSHomeTableViewCellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSHomeTableViewCell"];
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSHomeTableViewCell" owner:self options:nil].firstObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.cellArr = @[];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSDrivingDetailsViewController *vc = [[EDSDrivingDetailsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
