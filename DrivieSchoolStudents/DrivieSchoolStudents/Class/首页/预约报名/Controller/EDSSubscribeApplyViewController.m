//
//  EDSSubscribeApplyViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSubscribeApplyViewController.h"
#import "EDSDrivingSchoolInformationViewController.h"

#import "HomeConstants.h"

#import "EDSSubscribeApplyOneTableViewCell.h"
#import "EDSSubscribeApplyTwoTableViewCell.h"

@interface EDSSubscribeApplyViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@end

@implementation EDSSubscribeApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"预约报名";
    
    [self setup];

//    选择驾校
//    EDSDrivingSchoolInformationViewController *vc = [[EDSDrivingSchoolInformationViewController alloc] init];
//    vc.firstBtnString = @"联盟驾校";
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setup{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = ClearColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-100);
    }];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:PLACEHOLDERGOODSIMAGE];
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.showPageControl = YES;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.frame = CGRectMake(0, 0, kScreenWidth, EDSHomeTableViewHeaderSlideH);
    self.tableView.tableHeaderView = cycleScrollView;
    cycleScrollView.imageURLStringsGroup = @[
                                             @"http://pic35.photophoto.cn/20150516/0005018639255973_b.jpg",
                                             @"http://pic35.photophoto.cn/20150516/0005018639255973_b.jpg",
                                             ];
    
    UIButton *determineBtn = [[UIButton alloc] init];
    [determineBtn setTitle:@"确认预约" forState:UIControlStateNormal];
    [determineBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    determineBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    determineBtn.backgroundColor = ThemeColor;
    determineBtn.layer.cornerRadius = 5;
    determineBtn.layer.masksToBounds = YES;
    [self.view addSubview:determineBtn];
    [determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(-18);
    }];
    
    UILabel *label = [UILabel labelWithText:@"注：驾校工作时间为9:00:00-17:00:00" font:kFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self.view];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(determineBtn.mas_top).mas_equalTo(-25);
    }];
}


#pragma make ------ tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return EDSSubscribeApplyOneTableViewCellH;

    }else{
        
        return EDSSubscribeApplyTwoTableViewCellH;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        EDSSubscribeApplyOneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSSubscribeApplyOneTableViewCell"];
        
        if (!cell) {
            cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSSubscribeApplyOneTableViewCell" owner:self options:nil].firstObject;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = TableColor;
        
        return cell;
    }else{
        
        EDSSubscribeApplyTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSSubscribeApplyTwoTableViewCell"];
        
        if (!cell) {
            cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSSubscribeApplyTwoTableViewCell" owner:self options:nil].firstObject;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = TableColor;
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView viewWithBackgroundColor:TableColor superView:nil];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView viewWithBackgroundColor:TableColor superView:nil];
}

@end
