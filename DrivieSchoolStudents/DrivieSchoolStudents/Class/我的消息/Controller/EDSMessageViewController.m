//
//  EDSMessageViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSMessageViewController.h"
#import "EDSMessageDetailViewController.h"
#import "EDSPSWLogoViewController.h"
#import "PopAnimator.h"
#import "EDSMessageSiginBoxViewController.h"
#import "EDSOnlineAboutClassDetailAppointmentViewController.h"

#import "EDSHeaderPageButtonView.h"
#import "EDSMessageTableViewCell.h"

#import "EDSStudentMsgRequest.h"
#import "EDSStudentMsgDetailRequest.h"
#import "EDSOnlineClassListDetailRequest.h"

#import "EDSStudentMsgModel.h"

@interface EDSMessageViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSString *_type;
}

@property (nonatomic, strong) PopAnimator *popAnimator;
@property (nonatomic , strong) EDSHeaderPageButtonView *headerView;
@property (nonatomic , strong) NSArray <EDSStudentMsgModel *> *tableViewArr;

@end

@implementation EDSMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _type = @"1";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    
    [self tableViewPullUp];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([EDSSave account].userID.length == 0) {
        
        EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        [self.tableView.mj_header beginRefreshing];
    }
}

#pragma mark ----- 网络请求
- (void)tableViewPullUp
{
    @weakify(self);
    self.tableView.mj_header = [EDSRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self requestDataWithType:self->_type];
    }];
}

- (void)requestDataWithType:(NSString *)type
{
    EDSStudentMsgRequest *request = [EDSStudentMsgRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (errCode == 1) {
            
            self.tableViewArr = model;
            [self.tableView reloadData];
        }else if (errCode == -2){
            
            EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
    } failureBlock:^(NSError *error) {
    
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    request.phone = [EDSSave account].phone;
    request.type = type;
    request.showHUD = YES;
    [request  startRequest];
}

#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EDSMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EDSMessageTableViewCell"];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EDSMessageTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.mesModel = self.tableViewArr[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.tableViewArr[indexPath.row].msgType isEqualToString:@"4"]) {
        //签到提醒
        CGFloat width = 305;
        
        CGFloat height = 166;
        
        CGRect coverFrame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
        CGRect presentedFrame = CGRectMake((kScreenWidth - width)*0.5,175, width, height);
        
        self.popAnimator = [[PopAnimator alloc]initWithCoverFrame:coverFrame presentedFrame:presentedFrame startPoint:CGPointMake(0.5, 0.5) startTransform:CGAffineTransformMakeScale(0.5, 0.5) endTransform:CGAffineTransformMakeScale(0.0001, 0.0001)];
        
        self.popAnimator.isClose = YES;
        
        EDSMessageSiginBoxViewController *vc = [[EDSMessageSiginBoxViewController alloc] initWithNibName:@"EDSMessageSiginBoxViewController" bundle:[NSBundle mainBundle]];
        
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.msgModel = self.tableViewArr[indexPath.row];
        
        vc.view.layer.masksToBounds = YES;
        vc.view.layer.cornerRadius = 5;
        
        vc.transitioningDelegate = self.popAnimator;
        
        @weakify(self);
        vc.messageSiginBoxViewControllerDidClick = ^(EDSOnlineClassListByDateModel *model) {
          
            @strongify(self);
            
            EDSOnlineAboutClassDetailAppointmentViewController *vc = [[EDSOnlineAboutClassDetailAppointmentViewController alloc] init];
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        [self presentViewController:vc animated:YES completion:nil];
        
    }else if ([self.tableViewArr[indexPath.row].msgType isEqualToString:@"3"]){
        
        [self jumpPageViewWithMsgId:self.tableViewArr[indexPath.row].msgId];
    }
    else{
        EDSMessageDetailViewController *vc = [[EDSMessageDetailViewController alloc] init];
        vc.msgModel = self.tableViewArr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)jumpPageViewWithMsgId:(NSString *)msgId
{
    
    @weakify(self);
    EDSStudentMsgDetailRequest *request = [EDSStudentMsgDetailRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        if (errCode == 1) {
            
            NSString *courseRecordId = responseDict[@"courseRecordId"];
            NSString *appointmentId = responseDict[@"appointmentId"];
            NSString *studentId = responseDict[@"studentId"];
            
            [self onlineClassListDetailRequestWithAppointmentId:appointmentId studentId:studentId];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    request.msgId = msgId;
    [request  startRequest];
}


- (void)onlineClassListDetailRequestWithAppointmentId:(NSString *)appointmentId studentId:(NSString *)studentId
{
    @weakify(self);
    EDSOnlineClassListDetailRequest *request = [EDSOnlineClassListDetailRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        
        EDSOnlineAboutClassDetailAppointmentViewController *vc = [[EDSOnlineAboutClassDetailAppointmentViewController alloc] init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    } failureBlock:^(NSError *error) {
        
    }];
    request.showHUD = YES;
    request.appointmentId = appointmentId;
    request.studentId = studentId;
    [request startRequest];
}

- (EDSHeaderPageButtonView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[EDSHeaderPageButtonView alloc] init];
        _headerView.btnArr = @[@"系统",@"驾校"];
        [self.view addSubview:_headerView];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(45);
        }];
        @weakify(self);
        _headerView.headerPageButtonDidSelectStringback = ^(NSString *titleStr) {
            @strongify(self);
            
            if ([titleStr isEqualToString:@"系统"]) {
                
                self->_type = @"1";
            }else
            {
                self->_type = @"2";
            }
            
            [self requestDataWithType:self->_type];
        };
    }
    return _headerView;
}
@end
