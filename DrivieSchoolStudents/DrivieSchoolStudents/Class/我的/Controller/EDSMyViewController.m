//
//  EDSMyViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSMyViewController.h"
#import "EDSSchoolMessageViewController.h"//学校信箱
#import "EDSPersonalSettingsViewController.h"//个人设置
#import "EDSCourseRecordViewController.h"//课程记录
#import "EDSLearningSituationViewController.h"//学习情况
#import "EDSPSWLogoViewController.h"
#import "EDSAboutUsViewController.h"//关于我们
#import "EDSDrivingShcoolDetailViewController.h"//驾校详情
#import <SDImageCache.h>

#import "EDSMyTableViewCell.h"
#import "EDSMyHeaderView.h"
#import "MyConstants.h"
#import "LXAlterPromptView.h"
#import "LXCacheManager.h"

#import "EDSGetStudentInfoRequest.h"
#import "EDSVersionUpdateRequest.h"

@interface EDSMyViewController ()<UITableViewDelegate,UITableViewDataSource,LXAlterPromptViewDelegate>

/** 数据 */
@property (nonatomic, strong) NSArray  *cellArr;
/** 头部试图 */
@property (nonatomic, strong)  EDSMyHeaderView *headerView;
/// 背景图
@property (nonatomic, strong) UIView *alterBgView;
@property (nonatomic, strong) LXAlterPromptView *promptView;

@end

@implementation EDSMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, MyTableViewSeparatorLeft, 0, 0);
    
    @weakify(self);
    self.headerView.headerImgViewDidClick = ^{
        @strongify(self);
        EDSPersonalSettingsViewController *vc = [[EDSPersonalSettingsViewController alloc] initWithNibName:@"EDSPersonalSettingsViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
    };
    self.tableView.tableHeaderView = self.headerView;
    
    
    self.cellArr = @[];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([EDSToolClass isBlankString:[EDSSave account].userID]) {
        
        EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        @weakify(self);
        EDSGetStudentInfoRequest *request = [EDSGetStudentInfoRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
            if (errCode == 1){
                @strongify(self);
                NSString *string = [EDSToolClass isBlankString:[EDSSave account].schoolId]  ? @"我的报名" : @"我的驾校";
                self.cellArr = @[
                                 @[
                                     @[string,@"wdbm_content_icon_default"],
                                     @[@"课程记录",@"kcjl_content_icon_default"],
                                     @[@"学习查询",@"xxcx_content_icon_default"],
                                     @[@"学校信箱",@"xxxx_content_icon_default"],
                                     ],
                                 @[
                                     @[@"刷新缓存",@"sxhc_content_icon_default" , @""],
                                     @[@"检查更新",@"jcgx_content_icon_default"],
                                     @[@"关于我们",@"gywm_content_icon_default"],
                                     ],
                                 ];
                
                self.headerView.headerArr = @[];
                [self.tableView reloadData];
            }
            
        } failureBlock:^(NSError *error) {
        
        }];
        request.phone = [EDSSave account].phone;
        [request startRequest];
    }
    
}



#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellArr[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSMyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSMyTableViewCell"];
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSMyTableViewCell" owner:self options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.cellArr = self.cellArr[indexPath.section][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MyTableViewCellH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView viewWithBackgroundColor:TableColor superView:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = self.cellArr[indexPath.section][indexPath.row][0];
    if ([string isEqualToString:@"学校信箱"]) {
        
        EDSSchoolMessageViewController *vc = [[EDSSchoolMessageViewController alloc] initWithNibName:@"EDSSchoolMessageViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([string isEqualToString:@"课程记录"]){
        
        if ([EDSSave account].schoolId.length > 0) {
            
            EDSCourseRecordViewController *vc = [[EDSCourseRecordViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
//            [SVProgressHUD showErrorWithStatus:@"您还没有报名^_^!"];
//            [SVProgressHUD dismissWithDelay:1.5];
            [self.view makeToast:@"您还没有报名^_^!"];
        }
    }else if ([string isEqualToString:@"学习查询"]){
        
        if ([EDSSave account].schoolId.length > 0) {
            
            EDSLearningSituationViewController *vc = [[EDSLearningSituationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
//            [SVProgressHUD showErrorWithStatus:@"您还没有报名^_^!"];
//            [SVProgressHUD dismissWithDelay:1.5];
            [self.view makeToast:@"您还没有报名^_^!"];
        }
    }else if ([string isEqualToString:@"关于我们"]){
        
        EDSAboutUsViewController *vc = [[EDSAboutUsViewController alloc] initWithNibName:@"EDSAboutUsViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([string isEqualToString:@"我的驾校"]){
        
        EDSDrivingShcoolDetailViewController *vc = [[EDSDrivingShcoolDetailViewController alloc] init];
        vc.schoolId = [EDSSave account].schoolId;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([string isEqualToString:@"刷新缓存"]){
        
        // 刷新缓存
        NSString *size = [LXCacheManager readCacheSize];
        if ([size floatValue] == 0) {
            [self.view makeToast:@"没有可清理的缓存数据"];
        }else {
            [self.view addSubview:self.alterBgView];
            [self.alterBgView addSubview:self.promptView];
            self.promptView.wz_centerX = self.alterBgView.wz_centerX;
            self.promptView.wz_centerY = self.alterBgView.wz_centerY;
            self.promptView.alterString = [NSString stringWithFormat:@"是否清除%@的缓存？",size];
        }
        
    }else if ([string isEqualToString:@"检查更新"]){
        
        @weakify(self);
        EDSVersionUpdateRequest *request = [EDSVersionUpdateRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
            @strongify(self);
            
            [self.view makeToast:@"您已经是最新版本不需要更新"];
        } failureBlock:^(NSError *error) {
        
        }];
        request.title = @"乐享学员APP版本(iOS)";
        [request startRequest];
    }else if ([string isEqualToString:@"我的报名"]){
        
        [self.view makeToast:@"您还没有报名"];
    }
}

#pragma mark ------------------------ 懒加载 --------------------------------
- (EDSMyHeaderView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[EDSMyHeaderView alloc] init];
        _headerView.wz_size = CGSizeMake(kScreenWidth, MyTableViewHeaderViewH);
    }
    return _headerView;
}

#pragma mark - LXAlterPromptViewDelegate
/// 取消按钮
- (void)lx_cancelClickButton {
    [self.alterBgView removeFromSuperview];
}

/// 确认按钮
- (void)lx_enterClickButton {
    [LXCacheManager cleanCacheSize];
    [self.alterBgView removeFromSuperview];
    [self.view makeToast:@"清除成功"];
}

- (UIView *)alterBgView {
    if (!_alterBgView) {
        _alterBgView = [[UIView alloc] init];
        _alterBgView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _alterBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    }
    return _alterBgView;
}

- (LXAlterPromptView *)promptView {
    if (!_promptView) {
        _promptView = [[LXAlterPromptView alloc] init];
        _promptView.frame = CGRectMake(73, 100, 230, 140);
        _promptView.delegate = self;
    }
    return _promptView;
}
@end
