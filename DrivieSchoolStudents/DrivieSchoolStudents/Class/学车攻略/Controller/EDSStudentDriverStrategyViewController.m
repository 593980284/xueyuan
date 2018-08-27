//
//  EDSStudentDriverStrategyViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentDriverStrategyViewController.h"

#import "EDSStudentDriverStrategyHeaderView.h"
#import "EDSStudentDriverStrategSubTableViewCell.h"

#import "StudentDriverStrategConstants.h"

@interface EDSStudentDriverStrategyViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation EDSStudentDriverStrategyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EDSStudentDriverStrategyHeaderView *headerView = [[EDSStudentDriverStrategyHeaderView alloc] init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(StudentDriverStrategHeaderViewH);
    }];
    headerView.viewDidSelectBtnBlock = ^(NSString *backBlock) {
        DLog(@"%@",backBlock);
    };
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(StudentDriverStrategHeaderViewH);
        make.bottom.mas_equalTo(0);
    }];
}


#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSStudentDriverStrategSubTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSStudentDriverStrategSubTableViewCell"];
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSStudentDriverStrategSubTableViewCell" owner:self options:nil].firstObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return StudentDriverStrategTableViewCellH;
}
@end
