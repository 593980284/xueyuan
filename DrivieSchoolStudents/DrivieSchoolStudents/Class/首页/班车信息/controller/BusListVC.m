//
//  BusListVC.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2019/3/2.
//  Copyright © 2019年 班文政. All rights reserved.
//

#import "BusListVC.h"
#import "CarTableViewCell.h"
#import "EDSBusInfoVC.h"
#import "CarRequest.h"
@interface BusListVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)NSMutableArray *dataArr;
@property(nonatomic, assign)NSInteger page;
@end

@implementation BusListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray new];
     self.navigationItem.title = @"班车列表";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CarTableViewCell class] forCellReuseIdentifier:@"CarTableViewCell"];
    self.tableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight - kNavigationH);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)refreshData
{
    MJWeakSelf
    self.page = 1;
    CarRequest * request = [CarRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, NSArray * model) {
        weakSelf.dataArr = [model mutableCopy];
        [weakSelf.tableView reloadData];
        if (model.count < 10) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
           [weakSelf.tableView.mj_footer resetNoMoreData];
        }
        [weakSelf.tableView.mj_header endRefreshing];
    } failureBlock:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    request.page = 1;
    request.rows = 10;
    request.schoolId = [EDSSave account].schoolId;
    [request startRequest];
}

- (void)getMoreData
{
    MJWeakSelf
    self.page++;
    CarRequest * request = [CarRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, NSArray* model) {
        [weakSelf.dataArr addObjectsFromArray:model];
        [weakSelf.tableView reloadData];
        if (model && model.count == 10) {
            [weakSelf.tableView.mj_footer endRefreshing];
        }else{
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failureBlock:^(NSError *error) {
       [weakSelf.tableView.mj_footer endRefreshing];
    }];
    request.page = self.page;
    request.rows = 10;
    request.schoolId = [EDSSave account].schoolId;
    [request startRequest];
}

#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CarTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CarTableViewCell" forIndexPath:indexPath];
    cell.dic = self.dataArr[indexPath.row];
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * tempDic = self.dataArr[indexPath.row];
    EDSBusInfoVC * infoVC = [EDSBusInfoVC new];
    infoVC.busInfoId = tempDic[@"id"];
    [self.navigationController pushViewController:infoVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170*HC_750Ratio;
}

@end
