//
//  EDSOnlineAboutClassViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineAboutClassViewController.h"
#import "EDSOnlineAboutClassDetailAppointmentViewController.h"

#import "EDSOnlineAboutClassTableViewCell.h"
#import "EDSOnlineAboutClassHeaderView.h"
#import "EDSOnlineAboutClassTableViewHeaderView.h"

#import "EDSOnlineClassDateListModel.h"

#import "EDSOnlineClassDateListRequest.h"
#import "EDSOnlineClassListByDateRequest.h"

@interface EDSOnlineAboutClassViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) NSArray <EDSOnlineClassDateListModel *> *dataArr;
@property (nonatomic , strong) EDSOnlineAboutClassTableViewHeaderView *headerView;


@end

@implementation EDSOnlineAboutClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"在线约课";
    
    self.dataArr = [[NSArray alloc] init];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(140);
    }];
    
    [self requesDateListData];
}


#pragma mark ------------------------ 网络请求 --------------------------------
//获取排班
- (void)requesDateListData
{
    EDSOnlineClassDateListRequest *request = [EDSOnlineClassDateListRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            
            self.dataArr = model;
            self.headerView.dataArr = self.dataArr;
            [self requestListByDateDataWithDate:self.dataArr[0].date];
        }
    } failureBlock:^(NSError *error) {
    
    }];
    request.phone = [EDSSave account].phone;
    [request startRequest];
}

- (void)requestListByDateDataWithDate:(NSString *)date
{
    EDSOnlineClassListByDateRequest *request = [EDSOnlineClassListByDateRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            
        }
    } failureBlock:^(NSError *error) {
    
    }];
    request.phone = [EDSSave account].phone;
    request.date = date;
    [request  startRequest];
}

#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSOnlineAboutClassTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSOnlineAboutClassTableViewCell"];
    
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSOnlineAboutClassTableViewCell" owner:self options:nil].firstObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = WhiteColor;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    EDSOnlineAboutClassHeaderView *headerView = [[EDSOnlineAboutClassHeaderView alloc] init];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSOnlineAboutClassDetailAppointmentViewController *vc = [[EDSOnlineAboutClassDetailAppointmentViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (EDSOnlineAboutClassTableViewHeaderView *)headerView
{
    if (!_headerView) {
        
        
        _headerView = [[EDSOnlineAboutClassTableViewHeaderView alloc] init];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, 140);
        [self.view addSubview:_headerView];
        @weakify(self);
        _headerView.onlineAboutClassTableViewHeaderViewDidBackData = ^(NSString *datastr) {
            @strongify(self);
            [self requestListByDateDataWithDate:datastr];
        };
    }
    return _headerView;
}
@end
