//
//  EDSCourseRecordViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordViewController.h"
#import "EDSCourseRecordDetailViewController.h"//课程详情
#import "EDSUnCourseRecordViewController.h"//未完成课程详情

#import "EDSCourseRecordTableViewCell.h"
#import "EDSCourseRecordCompleteTableViewCell.h"
#import "EDSCourseRecordHeaderView.h"
#import "EDSHeaderPageButtonView.h"

#import "EDSStudentCourseRecordRequest.h"

#import "EDSCourseRecordModel.h"

@interface EDSCourseRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isFinish;
    BOOL _fitst;
}

//@property (nonatomic , strong) NSArray <EDSCourseRecordModel *> *clistArr;
//@property (nonatomic , strong) NSArray <EDSCourseRecordModel *> *ulistArr;

@property (nonatomic , strong) NSArray <EDSCourseRecordModel *> *arr;
@end

@implementation EDSCourseRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"课程记录";
    _isFinish = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource =  self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self requestData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.page++;
        [self requestData];
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(45);
    }];
    
    EDSHeaderPageButtonView *headerView = [[EDSHeaderPageButtonView alloc] init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    headerView.btnArr = @[@"已完成课程",@"未完成课程"];
    headerView.headerPageButtonDidSelectStringback = ^(NSString *titleStr) {
        [self.tableView.mj_header beginRefreshing];
        if ([titleStr isEqualToString:@"已完成课程"]) {
            
            self->_isFinish = YES;
        }else{
            self->_isFinish = NO;
        }
    };
    [self.tableView.mj_header beginRefreshing];
    _fitst = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_fitst == YES) {
         _fitst = NO;
        return;
    }
    self.page = 1;
    [self requestData];
}

#pragma mark ------------------------ 网络请求
- (void)requestData
{
    @weakify(self);
    EDSStudentCourseRecordRequest *request = [EDSStudentCourseRecordRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        if (errCode == 1) {
            NSMutableArray *data = model[1];
            if (self->_isFinish) {
                data = model[0];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if (data.count == 0) {
                 [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            if (self.page > 1) {
                NSMutableArray *arr = [self.arr mutableCopy];
                [arr addObjectsFromArray:data];
                self.arr = arr;
            }else{
                self.arr = data;
            }
            [self.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
    
    }];
    request.myPage = self.page;
    [request  startRequest];
}

#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isFinish) {
        
        EDSCourseRecordCompleteTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSCourseRecordCompleteTableViewCell"];
        
        if (!cell) {
            cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSCourseRecordCompleteTableViewCell" owner:self options:nil].firstObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.courseRecordModel = self.arr[indexPath.row];
        
        return cell;
    }else{
        EDSCourseRecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSCourseRecordTableViewCell"];
        
        if (!cell) {
            cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSCourseRecordTableViewCell" owner:self options:nil].firstObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.courseRecordModel = self.arr[indexPath.row];
        
        return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_isFinish) {
        
        EDSCourseRecordDetailViewController *vc = [[EDSCourseRecordDetailViewController alloc] init];
        vc.courseRecordModel = self.arr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        EDSUnCourseRecordViewController *vc = [[EDSUnCourseRecordViewController alloc] initWithNibName:@"EDSUnCourseRecordViewController" bundle:[NSBundle mainBundle]];
        vc.courseRecordModel = self.arr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
