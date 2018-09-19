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

#import "EDSMyTableViewCell.h"
#import "EDSMyHeaderView.h"
#import "MyConstants.h"

#import "EDSGetStudentInfoRequest.h"

@interface EDSMyViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 数据 */
@property (nonatomic, strong) NSArray  *cellArr;
/** 头部试图 */
@property (nonatomic, strong)  EDSMyHeaderView *headerView;

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([EDSSave account].userID.length == 0) {
        
        EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        
        EDSGetStudentInfoRequest *request = [EDSGetStudentInfoRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
            
            if (errCode == -2) {
                
                EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
                
            }else if (errCode == 1){
                
                NSString *string = [EDSSave account].schoolId.length > 0 ? @"我的驾校" : @"我的报名";
                DLog(@"%@",[EDSSave account].schoolId);
                self.cellArr = @[
                                 @[
                                     @[string,@"wdbm_content_icon_default"],
                                     @[@"课程记录",@"kcjl_content_icon_default"],
                                     @[@"学习查询",@"xxcx_content_icon_default"],
                                     @[@"学校信箱",@"xxxx_content_icon_default"],
                                     ],
                                 @[
                                     @[@"刷新缓存",@"sxhc_content_icon_default"],
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
    
    NSString *string = [EDSSave account].schoolId.length > 0 ? @"我的驾校" : @"我的报名";
    DLog(@"%@",[EDSSave account].schoolId);
    self.cellArr = @[
                     @[
                         @[string,@"wdbm_content_icon_default"],
                         @[@"课程记录",@"kcjl_content_icon_default"],
                         @[@"学习查询",@"xxcx_content_icon_default"],
                         @[@"学校信箱",@"xxxx_content_icon_default"],
                         ],
                     @[
                         @[@"刷新缓存",@"sxhc_content_icon_default"],
                         @[@"检查更新",@"jcgx_content_icon_default"],
                         @[@"关于我们",@"gywm_content_icon_default"],
                         ],
                     ];
    
    self.headerView.headerArr = @[];
    [self.tableView reloadData];
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
        
        EDSCourseRecordViewController *vc = [[EDSCourseRecordViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([string isEqualToString:@"学习查询"]){
        
        EDSLearningSituationViewController *vc = [[EDSLearningSituationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([string isEqualToString:@"关于我们"]){
        
        EDSAboutUsViewController *vc = [[EDSAboutUsViewController alloc] initWithNibName:@"EDSAboutUsViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([string isEqualToString:@"我的驾校"]){
        
        EDSDrivingShcoolDetailViewController *vc = [[EDSDrivingShcoolDetailViewController alloc] init];
        vc.schoolId = [EDSSave account].schoolId;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([string isEqualToString:@"刷新缓存"]){
        
        [SVProgressHUD showWithStatus:@"正在清除缓存···"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
//                NSFileManager *mgr = [NSFileManager defaultManager];
//                [mgr removeItemAtPath:GYLCustomFile error:nil];
//                [mgr createDirectoryAtPath:GYLCustomFile withIntermediateDirectories:YES attributes:nil error:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [SVProgressHUD dismiss];
                    
                    // 设置文字
//                    self.detailTextLabel.text = nil;
                });
            });
        }];
        
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
@end
