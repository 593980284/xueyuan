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
#import "EDSElegantDemeanourViewController.h"
#import "ComplaintViewController.h"
#import "HtmlVC.h"

#import "EDSHomeTableViewHeaderView.h"
#import "EDSHomeTableViewCell.h"
#import "CarTableViewCell.h"
#import "StyleTableViewCell.h"

#import "EDSHomeSchoolInformationRequest.h"
#import "EDSSchoolStyleRequest.h"
#import "CarRequest.h"
#import "LunRequest.h"
#import "EDSSchoolStyleModel.h"

#import "EDSDrivingSchoolModel.h"

#import "HomeConstants.h"
#import "HomeHeaderView.h"

#import "EDSBusInfoVC.h"

@interface EDSHomeViewController ()<UITableViewDataSource,UITableViewDelegate,EDSHomeTableViewHeaderViewDelegate>

/** 驾校消息 */
@property (nonatomic, strong) NSArray<EDSDrivingSchoolModel *>  *tableViewListArr;
@property (nonatomic, strong) EDSHomeTableViewHeaderView *headerView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) NSArray<EDSSchoolStyleModel *> *schoolStyleArr;
@property (nonatomic, strong) NSArray *carArr;

@end

@implementation EDSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"乐享学驾";
    [self setupNavigationView];
    self.tableViewListArr = [[NSArray alloc] init];
    self.tableViewStyle = UITableViewStyleGrouped;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[HomeHeaderView class] forHeaderFooterViewReuseIdentifier:@"HomeHeaderView"];
     [self.tableView registerClass:[CarTableViewCell class] forCellReuseIdentifier:@"CarTableViewCell"];
    [self.tableView registerClass:[StyleTableViewCell class] forCellReuseIdentifier:@"StyleTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _headerView = [[EDSHomeTableViewHeaderView alloc] init];
    _headerView.delegate = self;
    _headerView.wz_size = CGSizeMake(kScreenWidth, EDSHomeTableViewHeaderSlideH+EDSHomeTableViewHeaderButtonBgH);
    _headerView.headerArr = @[];
    self.tableView.tableHeaderView = _headerView;
    if (@available(iOS 11.0, *)) {
         self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
       self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(homeRequestData)];
    self.tableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight - KTabBarHeight);
    [NotificationCenter addObserver:self selector:@selector(homeFuntionBtnClick:) name:kZSNotificationHomeBtnCenter object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([EDSToolClass isBlankString:[EDSSave account].userID]) {
         self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    }else{
         self.tableView.mj_footer = nil;
    }
    [self homeRequestData];
    
    _headerView.headerArr = @[];
    [self setupNavigationView];
   
         [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
   [super viewWillDisappear:animated];
    if (self.navigationController.childViewControllers.count > 1) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
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
    }else if ([titleStr isEqualToString:@"我要报名"]){
        
        EDSSubscribeApplyViewController *vc = [[EDSSubscribeApplyViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([titleStr isEqualToString:@"我要约课"]){//
        
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
//        if (![EDSToolClass isBlankString:[EDSSave account].userID]) {
        
            EDSTheoryLearningViewController *vc = [[EDSTheoryLearningViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
//        }else{
//
//            EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
//            [self presentViewController:vc animated:YES completion:nil];
//        }
    }else if ([titleStr isEqualToString:@"品牌驾校"]){
        
        EDSBrandIntroductionViewController *vc = [[EDSBrandIntroductionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([titleStr isEqualToString:@"我要约考"]){//
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
        
//        if (![EDSToolClass isBlankString:[EDSSave account].userID]) {
            ComplaintViewController *vc = [[ComplaintViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
//        }else{
//
//            EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
//            [self presentViewController:vc animated:YES completion:nil];
//        }
        
    }else if ([titleStr isEqualToString:@"报名流程"]){
        
        EDSRegistrationProcessViewController *vc = [[EDSRegistrationProcessViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([titleStr isEqualToString:@"我的驾校"]){
        
        EDSDrivingShcoolDetailViewController *vc = [[EDSDrivingShcoolDetailViewController alloc] init];
        vc.schoolId = [EDSSave account].schoolId;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([titleStr isEqualToString:@"乐享论坛"]){
         [self.view makeToastActivity];
        LunRequest * req = [LunRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
            [self.view hideToastActivity];
            HtmlVC *vc = [HtmlVC new];
            vc.headerTitle = @"乐享论坛";
            vc.url = responseDict[@"forumUrl"];
            [self.navigationController pushViewController:vc animated:YES];
        } failureBlock:^(NSError *error) {
            [self.view hideToastActivity];
        }];
        
        [req startRequest];
    }
}

#pragma mark ------------------------ 网络请求 --------------------------------
- (void)homeRequestData
{
    self.page = 1;
    
    if ([EDSToolClass isBlankString:[EDSSave account].userID]) {
        EDSHomeSchoolInformationRequest *request2 = [EDSHomeSchoolInformationRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
            
            self.tableViewListArr = model;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer resetNoMoreData];
            
        } failureBlock:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
        }];
       
        request2.schoolId = @"0";
        request2.page = self.page;
        [request2 startRequest];
    }else{
        EDSSchoolStyleRequest *request = [EDSSchoolStyleRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
            self.schoolStyleArr = model;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        } failureBlock:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
        }];
        if ([EDSToolClass isBlankString:[EDSSave account].schoolId]) {
            request.schoolId = @"0";
        }else
        {
            request.schoolId = [EDSSave account].schoolId;
        }
        request.phone = [EDSSave account].phone;
        request.page = 1;
        request.rows = 4;
        [request startRequest];
        
        CarRequest *request2 = [CarRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
            self.carArr = model;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        } failureBlock:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
        }];
        
        request2.schoolId = [EDSSave account].schoolId;
        request2.page = 1;
        request2.rows = 2;
        [request2 startRequest];
    }
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
    if ([EDSSave account].userID.length > 0) {
        if (section == 0) {
            return self.carArr.count;
        }else{
             return ceilf(self.schoolStyleArr.count/2.0);
        }
    }else{
       return self.tableViewListArr.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
       if ([EDSSave account].userID.length > 0) {
           return 2;
       }else{
            return 1;
       }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
      if ([EDSSave account].userID.length > 0) {
          if (indexPath.section == 0) {
              CarTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CarTableViewCell" forIndexPath:indexPath];
             cell.dic = self.carArr[indexPath.row];
              return cell;
          }else{
               StyleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StyleTableViewCell" forIndexPath:indexPath];
              cell.leftView.model = self.schoolStyleArr[indexPath.row*2];
              if (self.schoolStyleArr.count >= indexPath.row*2 + 2) {
                cell.rightView.model = self.schoolStyleArr[indexPath.row*2 + 1];
              }
              cell.leftView.block = ^(EDSSchoolStyleModel *model) {
                  EDSElegantDemeanourViewController *vc = [[EDSElegantDemeanourViewController alloc] initWithNibName:@"EDSElegantDemeanourViewController" bundle:[NSBundle mainBundle]];
                  vc.schoolId = model.styleId;
                  [self.navigationController pushViewController:vc animated:YES];
              };
              cell.rightView.block = ^(EDSSchoolStyleModel *model) {
                  if (model == nil) {
                      return ;
                  }
                  EDSElegantDemeanourViewController *vc = [[EDSElegantDemeanourViewController alloc] initWithNibName:@"EDSElegantDemeanourViewController" bundle:[NSBundle mainBundle]];
                  vc.schoolId = model.styleId;
                  [self.navigationController pushViewController:vc animated:YES];
              };
              return cell;
          }
      }else{
          EDSHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSHomeTableViewCell"];
          if (!cell) {
              cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSHomeTableViewCell" owner:self options:nil].firstObject;
          }
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
          cell.model = self.tableViewListArr[indexPath.row];
          return cell;
      }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([EDSSave account].userID.length > 0) {
        if (indexPath.section == 0) {
 
            NSDictionary * tempDic = self.carArr[indexPath.row];
            EDSBusInfoVC * infoVC = [EDSBusInfoVC new];
            infoVC.busInfoId = tempDic[@"id"];
            [self.navigationController pushViewController:infoVC animated:YES];
        }else{
        
        }
        
    }else{
        EDSDrivingShcoolDetailViewController *vc = [[EDSDrivingShcoolDetailViewController alloc] init];
        vc.schoolId = self.tableViewListArr[indexPath.row].schoolId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *imageNamed = @"品牌驾校";
    NSString *title = @"品牌驾校";
    NSString *detail = @"（按首字母排序，排名不分先后）";
    NSString *more = @"";
    if ([EDSSave account].userID.length > 0) {
        detail = @"";
        title = @[@"班车信息",@"驾校风采"][section];
        imageNamed = @[@"班车信息",@"驾校风采"][section];
        more = @"更多>";
    }
    HomeHeaderView *headerView = [[HomeHeaderView alloc]initWithReuseIdentifier:@"HomeHeaderView"];
    headerView.bgImgView.image = [UIImage imageNamed:imageNamed];
    headerView.titleLb.text = title;
    headerView.detailLb.text = detail;
    headerView.moreLb.text = more;
    
//    headerView.clickActionBlock = ^{
//        EDSBusInfoVC *vc = [EDSBusInfoVC new];
//        [self.navigationController pushViewController:vc animated:YES];
//    };
    
    return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200*HC_750Ratio;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if ([EDSSave account].userID.length > 0) {
         if (indexPath.section == 0) {
             return 170*HC_750Ratio;
         }else{
            return 330*HC_750Ratio; // top 20 left 30
         }
     }else{
        return  109 + 15;
     }
}

- (void)dealloc
{
    [NotificationCenter removeObserver:self name:kZSNotificationHomeBtnCenter object:nil];
}

@end

