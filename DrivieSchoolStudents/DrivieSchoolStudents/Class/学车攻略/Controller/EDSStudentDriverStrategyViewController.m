//
//  EDSStudentDriverStrategyViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentDriverStrategyViewController.h"
#import "EDSPSWLogoViewController.h"
#import "EDSStudentDriverStrategyDetailViewController.h"

#import "EDSStudentDriverStrategyHeaderView.h"
#import "EDSStudentDriverStrategSubTableViewCell.h"

#import "EDSStrategyListRequest.h"

#import "EDSStrategyListModel.h"

#import "StudentDriverStrategConstants.h"

@interface EDSStudentDriverStrategyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_type;
}

@property (nonatomic , strong) NSArray<EDSStrategyListModel *> *tableArr;

@end

@implementation EDSStudentDriverStrategyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableArr = [[NSArray alloc] init];
    _type = @"0";
    self.page = 1;
    
    EDSStudentDriverStrategyHeaderView *headerView = [[EDSStudentDriverStrategyHeaderView alloc] init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(StudentDriverStrategHeaderViewH);
    }];
    @weakify(self);
    headerView.viewDidSelectBtnBlock = ^(NSString *backBlock) {
        DLog(@"%@",backBlock);
        @strongify(self);
        self->_type = backBlock;
        
        [self requestDataWithType:self->_type];
    };
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(StudentDriverStrategHeaderViewH);
        make.bottom.mas_equalTo(0);
    }];
    
    [self requestDataWithType:_type];
    [self tableViewPullUp];
}

#pragma mark ------------------------ 网络请求 ------------------------------
- (void)tableViewPullUp
{
    @weakify(self);
    self.tableView.mj_header = [EDSRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page = 1;
        [self requestDataWithType:self->_type];
    }];
    
    self.tableView.mj_footer = [EDSRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.page = self.page + 1 ;
        [self requestDataWithType:self->_type];
    }];
    self.tableView.mj_footer.hidden = NO;
}

- (void)requestDataWithType:(NSString *)type
{
    @weakify(self);
    EDSStrategyListRequest *request = [EDSStrategyListRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (errCode == 1) {
            
            NSArray<EDSStrategyListModel *> *arr = model;
            self.tableView.mj_footer.hidden = arr.count == [NumPerPage intValue] ? NO : YES;
            self.tableArr = model;
            [self.tableView reloadData];
        }else if (errCode == -2){
            
            EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
        
    } failureBlock:^(NSError *error) {
        
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    request.page = [NSString stringWithFormat:@"%ld",(long)self.page];
    request.strategyType = type;
    [request  startRequest];
}

#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSStudentDriverStrategSubTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSStudentDriverStrategSubTableViewCell"];
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSStudentDriverStrategSubTableViewCell" owner:self options:nil].firstObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.strategyListModel = self.tableArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return StudentDriverStrategTableViewCellH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSStudentDriverStrategyDetailViewController *vc = [[EDSStudentDriverStrategyDetailViewController alloc] initWithNibName:@"EDSStudentDriverStrategyDetailViewController" bundle:[NSBundle mainBundle]];
    vc.studyStrategyId = self.tableArr[indexPath.row].studyStrategyId;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
