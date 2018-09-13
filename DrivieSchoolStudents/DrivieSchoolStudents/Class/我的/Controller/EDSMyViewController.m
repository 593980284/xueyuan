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

#import "EDSMyTableViewCell.h"
#import "EDSMyHeaderView.h"
#import "MyConstants.h"

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
    
    self.cellArr = @[
                     @[
                         @[@"我的报名",@"wdbm_content_icon_default"],
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
    
    self.headerView.headerArr = @[];
    
    if ([EDSSave account].userID.length == 0) {
        
        EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
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
        
        EDSCourseRecordViewController *vc = [[EDSCourseRecordViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([string isEqualToString:@"学习查询"]){
        EDSLearningSituationViewController *vc = [[EDSLearningSituationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
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
