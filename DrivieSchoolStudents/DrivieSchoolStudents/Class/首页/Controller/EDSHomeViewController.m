//
//  EDSHomeViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSHomeViewController.h"
#import "EDSDrivingSchoolInformationViewController.h"//驾校信息
#import "EDSPSWLogoViewController.h"//登录

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
    
    EDSHomeTableViewHeaderView *headerView = [[EDSHomeTableViewHeaderView alloc] init];
    headerView.wz_size = CGSizeMake(kScreenWidth, EDSHomeTableViewHeaderSlideH+EDSHomeTableViewHeaderButtonBgH + 16);
    self.tableView.tableHeaderView = headerView;
    
//    EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
    
    [NotificationCenter addObserver:self selector:@selector(homeFuntionBtnClick:) name:kZSNotificationHomeBtnCenter object:nil];
}

- (void)setupNavigationView
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(homeRightBarButtonItemClick) image:@"dl_content_icon_defaut" highImage:@"dl_content_icon_defaut"];
}


- (void)homeRightBarButtonItemClick
{
    DLog(@"登录");
}

- (void)homeFuntionBtnClick:(NSNotification *)notification
{
    NSDictionary *dict = [notification valueForKey:@"userInfo"];
    NSString *titleStr = dict[@"name"];
    if ([titleStr isEqualToString:@"驾校信息"]) {
        
        EDSDrivingSchoolInformationViewController *vc = [[EDSDrivingSchoolInformationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.cellArr = @[];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return EDSHomeTableViewCellH;
}

- (void)dealloc
{
    [NotificationCenter removeObserver:self name:kZSNotificationHomeBtnCenter object:nil];
}

@end
