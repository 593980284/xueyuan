//
//  EDSOnlineAboutClassViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineAboutClassViewController.h"
#import "EDSOnlineAboutClassDetailAppointmentViewController.h"

#import "EDSOnlineAboutClassTableViewCell.h"
#import "EDSOnlineAboutClassHeaderView.h"
#import "EDSOnlineAboutClassTableViewHeaderView.h"

@interface EDSOnlineAboutClassViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation EDSOnlineAboutClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"在线约课";
    
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    EDSOnlineAboutClassTableViewHeaderView *headerView = [[EDSOnlineAboutClassTableViewHeaderView alloc] init];
    headerView.wz_size = CGSizeMake(kScreenWidth, 140);
    self.tableView.tableHeaderView = headerView;
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
    return 110;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSOnlineAboutClassTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSOnlineAboutClassTableViewCell"];
    
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSOnlineAboutClassTableViewCell" owner:self options:nil].firstObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = WhiteColor;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    EDSOnlineAboutClassHeaderView *headerView = [[EDSOnlineAboutClassHeaderView alloc] init];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSOnlineAboutClassDetailAppointmentViewController *vc = [[EDSOnlineAboutClassDetailAppointmentViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
