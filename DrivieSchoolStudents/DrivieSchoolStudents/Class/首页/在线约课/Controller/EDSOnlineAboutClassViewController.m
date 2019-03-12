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
#import "MyCoachViewController.h"
#import "SubjectTabbarRequest.h"
#import "SubjectListRequest.h"

@interface EDSOnlineAboutClassViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) NSArray <EDSOnlineClassDateListModel *> *dataArr;
@property (nonatomic , strong) EDSOnlineAboutClassTableViewHeaderView *headerView;
@property (nonatomic , strong) EDSHeaderPageButtonView *pageButtonView;
@property (nonatomic , copy) NSString *dateStr;
@property (nonatomic , copy) NSString *subjectId;

@property (nonatomic , strong) NSArray <EDSOnlineClassListByDateModel *> *list1Arr;
@property (nonatomic , strong) NSArray<SubjectTabbarModel *> *tabArr;


@property (nonatomic , strong) NSArray <EDSOnlineClassListByDateModel *> *tableViewListArr;

@end

@implementation EDSOnlineAboutClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"在线约课";
    self.
    
    self.dataArr = [[NSArray alloc] init];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(185);
    }];
    [self addNavigationBarRightButtonItemWithInfo:[UIImage imageNamed:@"形状11拷贝"] target:self action:@selector(gotoMyCoachVC)];
    [self requesDateListData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getList)];
    
}

- (void)gotoMyCoachVC{
    [self.navigationController pushViewController:[MyCoachViewController new] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![EDSToolClass isBlankString:[EDSSave account].userID]) {
        
        if (![EDSToolClass isBlankString:[EDSSave account].schoolId]) {
            
        }else{
            [self.view makeToast:@"您还没有报名^_^!"];
        }
    }else{
        
    }
    
    if (self.tabArr.count > 0) {
        
    }else{
        [self getTab];
    }
    if (_dateStr.length > 0) {
        
        //  [self requestListByDateDataWithDate:_dateStr];
    }else{
        [self requesDateListData];
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
            self.dateStr = self.dataArr[0].date;
            [self getList];
        }
    } failureBlock:^(NSError *error) {
        
    }];
    request.phone = [EDSSave account].phone;
    [request startRequest];
}

- (void)getTab
{
    SubjectTabbarRequest *requst = [SubjectTabbarRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, NSArray<SubjectTabbarModel *>* array) {
        self.tabArr = array;
        NSMutableArray *btnArr = [NSMutableArray new];
        for (SubjectTabbarModel * model  in array) {
            [btnArr addObject: model.subjectName];
        }
//        [btnArr addObjectsFromArray:@[@"实操都是",@"理当时的论",@"其他当时的"]];
        self.subjectId = array.firstObject.subjectId;
        self.pageButtonView.btnArr = btnArr;
        [self getList];
    } failureBlock:^(NSError *error) {
        
    }];
    [requst startRequest];
    
}

- (void)getList
{
    if (!self.subjectId) {
        return;
    }
    if (!self.dateStr) {
        return;
    }
    SubjectListRequest * request = [SubjectListRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, NSArray* model) {
        self.tableViewListArr = model;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failureBlock:^(NSError *error) {
         [self.tableView.mj_header endRefreshing];
    }];
    request.date = self.dateStr;
    request.subjectId = self.subjectId;
    [request startRequest];
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
    vc.appointmentId = self.tableViewListArr[indexPath.row].appointmentId;
    vc.studentId = self.tableViewListArr[indexPath.row].studentId;
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
            self.dateStr = datastr;
            [self.tableView.mj_header beginRefreshing];
        };
        
    }
    return _headerView;
}

- (EDSHeaderPageButtonView *)pageButtonView
{
    if (!_pageButtonView) {
        EDSHeaderPageButtonView *pageButtonView = [[EDSHeaderPageButtonView alloc] init];
        [self.view addSubview:pageButtonView];
        pageButtonView.clickBlock = ^(NSInteger index) {
            self.subjectId = self.tabArr[index].subjectId;
            [self.tableView.mj_header beginRefreshing];
        };
        // pageButtonView.btnArr = @[@"实操",@"理论",@"其他"];
        [pageButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.headerView.mas_bottom);
            make.height.mas_equalTo(45);
        }];
        _pageButtonView = pageButtonView;
    }
    return _pageButtonView;
}
@end
