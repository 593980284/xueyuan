//
//  EDSMessageViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSMessageViewController.h"
#import "EDSMessageDetailViewController.h"

#import "EDSHeaderPageButtonView.h"
#import "EDSMessageTableViewCell.h"

@interface EDSMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation EDSMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EDSHeaderPageButtonView *headerView = [[EDSHeaderPageButtonView alloc] init];
    headerView.btnArr = @[@"系统",@"驾校"];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(headerView.mas_bottom);
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
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EDSMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EDSMessageTableViewCell"];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EDSMessageTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSMessageDetailViewController *vc = [[EDSMessageDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
