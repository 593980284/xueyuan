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
}

@property (nonatomic , strong) NSArray <EDSCourseRecordModel *> *clistArr;
@property (nonatomic , strong) NSArray <EDSCourseRecordModel *> *ulistArr;

@end

@implementation EDSCourseRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"课程记录";
    _isFinish = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource =  self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
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
      
        if ([titleStr isEqualToString:@"已完成课程"]) {
            
            self->_isFinish = YES;
            [self.tableView reloadData];
        }else{
            
            self->_isFinish = NO;
            [self.tableView reloadData];
        }
    };
    
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}

#pragma mark ------------------------ 网络请求
- (void)requestData
{
    @weakify(self);
    EDSStudentCourseRecordRequest *request = [EDSStudentCourseRecordRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        if (errCode == 1) {
            
            self.clistArr = model[0];
            self.ulistArr = model[1];
            
            [self.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
    
    }];
    [request  startRequest];
}

#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _isFinish ? self.clistArr.count : self.ulistArr.count;
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
        
        cell.courseRecordModel = self.clistArr[indexPath.row];
        
        return cell;
    }else{
        EDSCourseRecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSCourseRecordTableViewCell"];
        
        if (!cell) {
            cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSCourseRecordTableViewCell" owner:self options:nil].firstObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.courseRecordModel = self.ulistArr[indexPath.row];
        
        return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_isFinish) {
        
        EDSCourseRecordDetailViewController *vc = [[EDSCourseRecordDetailViewController alloc] init];
        vc.courseRecordModel = self.clistArr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        EDSUnCourseRecordViewController *vc = [[EDSUnCourseRecordViewController alloc] initWithNibName:@"EDSUnCourseRecordViewController" bundle:[NSBundle mainBundle]];
        vc.courseRecordModel = self.ulistArr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
