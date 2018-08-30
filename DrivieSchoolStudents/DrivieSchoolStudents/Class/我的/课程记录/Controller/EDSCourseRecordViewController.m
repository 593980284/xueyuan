//
//  EDSCourseRecordViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordViewController.h"

#import "EDSCourseRecordTableViewCell.h"
#import "EDSCourseRecordCompleteTableViewCell.h"
#import "EDSCourseRecordHeaderView.h"

@interface EDSCourseRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation EDSCourseRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"课程记录";
    
    self.tableView.delegate = self;
    self.tableView.dataSource =  self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(45);
    }];
    
    EDSCourseRecordHeaderView *headerView = [[EDSCourseRecordHeaderView alloc] init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(45);
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    EDSCourseRecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSCourseRecordTableViewCell"];
//
//    if (!cell) {
//        cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSCourseRecordTableViewCell" owner:self options:nil].firstObject;
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    return cell;
    
    
    EDSCourseRecordCompleteTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSCourseRecordCompleteTableViewCell"];
    
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSCourseRecordCompleteTableViewCell" owner:self options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
