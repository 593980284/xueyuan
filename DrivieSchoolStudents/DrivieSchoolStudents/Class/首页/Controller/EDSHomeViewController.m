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
#import "EDSDrivingShcoolDetailViewController.h"//驾校详情
#import "EDSBrandIntroductionViewController.h"//品牌驾校
#import "EDSRegistrationProcessViewController.h"//报名流程
#import "EDSPricePublicViewController.h"//价格公示
#import "EDSOnlineAboutTestViewController.h"//在线约考
#import "ComplaintViewController.h"

#import "EDSHomeTableViewHeaderView.h"
#import "EDSHomeTableViewCell.h"

#import "EDSHomeSchoolInformationRequest.h"

#import "EDSDrivingSchoolModel.h"

#import "HomeConstants.h"

@interface EDSHomeViewController ()<UITableViewDataSource,UITableViewDelegate,EDSHomeTableViewHeaderViewDelegate>

/** 驾校消息 */
@property (nonatomic, strong) NSArray<EDSDrivingSchoolModel *>  *tableViewListArr;
@property (nonatomic , strong) EDSHomeTableViewHeaderView *headerView;

@end

@implementation EDSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"乐享学驾";
    [self setupNavigationView];
    self.tableViewListArr = [[NSArray alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _headerView = [[EDSHomeTableViewHeaderView alloc] init];
    _headerView.delegate = self;
    _headerView.wz_size = CGSizeMake(kScreenWidth, EDSHomeTableViewHeaderSlideH+EDSHomeTableViewHeaderButtonBgH + 16);
    _headerView.headerArr = @[];
    self.tableView.tableHeaderView = _headerView;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(homeRequestData)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    [NotificationCenter addObserver:self selector:@selector(homeFuntionBtnClick:) name:kZSNotificationHomeBtnCenter object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self homeRequestData];
    
    _headerView.headerArr = @[];
    
    [self setupNavigationView];
   
}

- (void)setupNavigationView
{
    NSLog(@"schoolId: %@",[EDSSave account].userID);
    if ([EDSToolClass isBlankString:[EDSSave account].userID]) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(homeRightBarButtonItemClick) image:@"dl_content_icon_defaut" highImage:@"dl_content_icon_defaut"];
        
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)homeHeaderViewCycleScrollViewBackDict:(NSDictionary *)dict
{
    if ([[NSString stringWithFormat:@"%@",dict[@"isInteractive"]] isEqualToString:@"1"]) {
        
        EDSOnlineAboutTestViewController *vc = [[EDSOnlineAboutTestViewController alloc] initWithNibName:@"EDSOnlineAboutTestViewController" bundle:[NSBundle mainBundle]];
        vc.webViewUrl = dict[@"interactiveContent"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
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
        
        if (![EDSToolClass isBlankString:[EDSSave account].userID]) {
            
            EDSDrivingSchoolInformationViewController *vc = [[EDSDrivingSchoolInformationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
    
            EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }else if ([titleStr isEqualToString:@"预约报名"]){
        
        EDSSubscribeApplyViewController *vc = [[EDSSubscribeApplyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([titleStr isEqualToString:@"在线约课"]){//
        
        if (![EDSToolClass isBlankString:[EDSSave account].userID]) {
            
            if (![EDSToolClass isBlankString:[EDSSave account].schoolId]) {
                
                EDSOnlineAboutClassViewController *vc = [[EDSOnlineAboutClassViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
//                [SVProgressHUD showErrorWithStatus:@"您还没有报名^_^!"];
//                [SVProgressHUD dismissWithDelay:1.5];
                [self.view makeToast:@"您还没有报名^_^!"];
            }
        }else{
            
            EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }else if ([titleStr isEqualToString:@"理论学习"]){//
        if (![EDSToolClass isBlankString:[EDSSave account].userID]) {
            
            EDSTheoryLearningViewController *vc = [[EDSTheoryLearningViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }else if ([titleStr isEqualToString:@"品牌驾校"]){
        
        EDSBrandIntroductionViewController *vc = [[EDSBrandIntroductionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([titleStr isEqualToString:@"在线约考"]){//
        if (![EDSToolClass isBlankString:[EDSSave account].schoolId]) {
            
            EDSOnlineAboutTestViewController *vc = [[EDSOnlineAboutTestViewController alloc] initWithNibName:@"EDSOnlineAboutTestViewController" bundle:[NSBundle mainBundle]];
            vc.webViewUrl = [EDSSave account].bookingExamUrl;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
//            [SVProgressHUD showErrorWithStatus:@"您还没有报名奥^_^!"];
//            [SVProgressHUD dismissWithDelay:1.5];
            [self.view makeToast:@"您还没有报名奥^_^!"];
        }
        
    }else if ([titleStr isEqualToString:@"我要投诉"]){
        
        if (![EDSToolClass isBlankString:[EDSSave account].userID]) {
            ComplaintViewController *vc = [[ComplaintViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
        
    }else if ([titleStr isEqualToString:@"我要报名"]){
        
        EDSRegistrationProcessViewController *vc = [[EDSRegistrationProcessViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([titleStr isEqualToString:@"我的报名"]){
        
        EDSDrivingShcoolDetailViewController *vc = [[EDSDrivingShcoolDetailViewController alloc] init];
        vc.schoolId = [EDSSave account].schoolId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark ------------------------ 网络请求 --------------------------------
- (void)homeRequestData
{
    self.page = 1;
    EDSHomeSchoolInformationRequest *request2 = [EDSHomeSchoolInformationRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        self.tableViewListArr = model;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failureBlock:^(NSError *error) {
         [self.tableView.mj_header endRefreshing];
    }];
    
    if ([EDSToolClass isBlankString:[EDSSave account].schoolId]) {
        
        request2.schoolId = @"0";
    }else
    {
        request2.schoolId = [EDSSave account].schoolId;
    }
    request2.page = self.page;
    [request2 startRequest];
}

- (void)getMoreData
{
    EDSHomeSchoolInformationRequest *request2 = [EDSHomeSchoolInformationRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, NSArray* model) {
        NSMutableArray *data = [self.tableViewListArr mutableCopy];
        [data addObjectsFromArray:model];
        self.tableViewListArr = [data copy];
        [self.tableView reloadData];
        if (model.count == 0) {
             [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failureBlock:^(NSError *error) {
        self.page--;
        [self.tableView.mj_footer endRefreshing];
    }];
    
//    if ([EDSToolClass isBlankString:[EDSSave account].schoolId]) {
//        
//        request2.schoolId = @"0";
//    }else
//    {
//        request2.schoolId = [EDSSave account].schoolId;
//    }
     request2.schoolId = @"0";
    self.page++;
    request2.page = self.page;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSDrivingShcoolDetailViewController *vc = [[EDSDrivingShcoolDetailViewController alloc] init];
    vc.schoolId = self.tableViewListArr[indexPath.section].schoolId;
    [self.navigationController pushViewController:vc animated:YES];
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

