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
#import "EDSHeaderPageButtonView.h"

#import "EDSOnlineClassDateListModel.h"
#import "EDSOnlineClassListByDateModel.h"

#import "EDSOnlineClassDateListRequest.h"
#import "EDSOnlineClassListByDateRequest.h"

@interface EDSOnlineAboutClassViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_dateStr;//日期
    NSString *_type;//选择什么类型的课程
}

@property (nonatomic , strong) NSArray <EDSOnlineClassDateListModel *> *dataArr;
@property (nonatomic , strong) EDSOnlineAboutClassTableViewHeaderView *headerView;

@property (nonatomic , strong) NSArray <EDSOnlineClassListByDateModel *> *list1Arr;
@property (nonatomic , strong) NSArray <EDSOnlineClassListByDateModel *> *list2Arr;
@property (nonatomic , strong) NSArray <EDSOnlineClassListByDateModel *> *list3Arr;


@property (nonatomic , strong) NSArray <EDSOnlineClassListByDateModel *> *tableViewListArr;

@end

@implementation EDSOnlineAboutClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"在线约课";
    
    self.dataArr = [[NSArray alloc] init];
    self->_type = @"1";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(185);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requesDateListData];
    if (_dateStr.length > 0) {
        
        [self requestListByDateDataWithDate:_dateStr];
    }
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
    @weakify(self);
    EDSOnlineClassListByDateRequest *request = [EDSOnlineClassListByDateRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        NSArray *modelArr = model;
        if (errCode == 1) {
            
            self.list1Arr = modelArr[0];
            self.list2Arr = modelArr[1];
            self.list3Arr = modelArr[2];
            
            if ([self->_type isEqualToString:@"1"]) {
                
                self.tableViewListArr = self.list1Arr;
            }else if ([self->_type isEqualToString:@"2"]){
                
                self.tableViewListArr = self.list2Arr;
            }else{
                
                self.tableViewListArr = self.list3Arr;
            }
            
            [self.tableView reloadData];
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
    return self.tableViewListArr.count;
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
    
    cell.model = self.tableViewListArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSOnlineAboutClassDetailAppointmentViewController *vc = [[EDSOnlineAboutClassDetailAppointmentViewController alloc] init];
    vc.model = self.tableViewListArr[indexPath.row];
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
            self->_dateStr = datastr;
            [self requestListByDateDataWithDate:self->_dateStr];
        };
        
        EDSHeaderPageButtonView *pageButtonView = [[EDSHeaderPageButtonView alloc] init];
        [self.view addSubview:pageButtonView];
        pageButtonView.headerPageButtonDidSelectStringback = ^(NSString *titleStr) {
            @strongify(self);
            if ([titleStr isEqualToString:@"科一/文明驾驶"]) {
                
                self->_type = @"1";
                self.tableViewListArr = self.list1Arr;
            }else if ([titleStr isEqualToString:@"科二/三"]){
                
                self->_type = @"2";
                self.tableViewListArr = self.list2Arr;
            }else if ([titleStr isEqualToString:@"其他"]){
                
                self->_type = @"3";
                self.tableViewListArr = self.list3Arr;
            }
            
            [self.tableView reloadData];
        };
        pageButtonView.btnArr = @[@"科一/文明驾驶",@"科二/三",@"其他"];
        [pageButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self->_headerView.mas_bottom);
            make.height.mas_equalTo(45);
        }];
    }
    return _headerView;
}
@end
