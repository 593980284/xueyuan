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
#import "EDSSubscribeApplyViewController.h"//预约报名
#import "EDSOnlineAboutClassViewController.h"//在线约课
#import "EDSTheoryLearningViewController.h"//理论学习

#import "EDSHomeTableViewHeaderView.h"
#import "EDSHomeTableViewCell.h"

#import "EDSHomeSchoolInformationRequest.h"

#import "EDSDrivingSchoolModel.h"

#import "HomeConstants.h"

@interface EDSHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 驾校消息 */
@property (nonatomic, strong) NSArray<EDSDrivingSchoolModel *>  *tableViewListArr;

@end

@implementation EDSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"乐享学驾";
    [self setupNavigationView];
    self.tableViewListArr = [[NSArray alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    EDSHomeTableViewHeaderView *headerView = [[EDSHomeTableViewHeaderView alloc] init];
    headerView.wz_size = CGSizeMake(kScreenWidth, EDSHomeTableViewHeaderSlideH+EDSHomeTableViewHeaderButtonBgH + 16);
    self.tableView.tableHeaderView = headerView;
    
    
    [NotificationCenter addObserver:self selector:@selector(homeFuntionBtnClick:) name:kZSNotificationHomeBtnCenter object:nil];
    
    [self homeRequestData];
}

- (void)setupNavigationView
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(homeRightBarButtonItemClick) image:@"dl_content_icon_defaut" highImage:@"dl_content_icon_defaut"];
}


- (void)homeRightBarButtonItemClick
{
    EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)homeFuntionBtnClick:(NSNotification *)notification
{
    NSDictionary *dict = [notification valueForKey:@"userInfo"];
    NSString *titleStr = dict[@"name"];
    if ([titleStr isEqualToString:@"驾校信息"]) {
        
        EDSDrivingSchoolInformationViewController *vc = [[EDSDrivingSchoolInformationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([titleStr isEqualToString:@"预约报名"]){
        
        EDSSubscribeApplyViewController *vc = [[EDSSubscribeApplyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([titleStr isEqualToString:@"在线约课"]){
        
        EDSOnlineAboutClassViewController *vc = [[EDSOnlineAboutClassViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([titleStr isEqualToString:@"理论学习"]){
        
        EDSTheoryLearningViewController *vc = [[EDSTheoryLearningViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ------------------------ 网络请求 --------------------------------
- (void)homeRequestData
{
   
    
    EDSHomeSchoolInformationRequest *request2 = [EDSHomeSchoolInformationRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        self.tableViewListArr = model;
        
        [self.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        
    }];
#warning 需要修改
    request2.schoolId = @"0";
    [request2 startRequest];
}


#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSHomeTableViewCell"];
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSHomeTableViewCell" owner:self options:nil].firstObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.tableViewListArr[indexPath.section];
    
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
