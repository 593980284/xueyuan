//
//  EDSHomeViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSHomeViewController.h"

#import "EDSHomeTableViewHeaderView.h"
#import "EDSHomeTableViewCell.h"

#import "HomeConstants.h"

@interface EDSHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation EDSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"乐享学驾";
    [self setupNavigationView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self.tableView registerNib:[UINib nibWithNibName:@"EDSHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"EDSHomeTableViewCell"];
    
    EDSHomeTableViewHeaderView *headerView = [[EDSHomeTableViewHeaderView alloc] init];
    headerView.wz_size = CGSizeMake(kScreenWidth, EDSHomeTableViewHeaderSlideH+EDSHomeTableViewHeaderButtonBgH + 16);
    self.tableView.tableHeaderView = headerView;
}

- (void)setupNavigationView
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(homeRightBarButtonItemClick) image:@"dl_content_icon_defaut" highImage:@"dl_content_icon_defaut"];
}


- (void)homeRightBarButtonItemClick
{
    DLog(@"登录");
}


#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSHomeTableViewCell"];
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSHomeTableViewCell" owner:self options:nil].firstObject;
    }
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return EDSHomeTableViewCellH;
}

@end
