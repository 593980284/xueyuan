//
//  EDSOnlineAboutClassDetailAppointmentViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineAboutClassDetailAppointmentViewController.h"

#import "EDSOnlineAboutClassDetailAppointmentHeaderView.h"
#import "EDSOnlineAboutClassDetailAppointmentTableViewCell.h"
#import "EDSOnlineAboutClassDetailAppointmentDownView.h"


#import "EDSOnlineClassListByDateModel.h"

@interface EDSOnlineAboutClassDetailAppointmentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) EDSOnlineAboutClassDetailAppointmentHeaderView *headerView;

@end

@implementation EDSOnlineAboutClassDetailAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"在线约课";
    
    
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    self.tableView.separatorColor = ClearColor;
//    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
//    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.mas_equalTo(0);
//        make.bottom.mas_equalTo(0);
//    }];
    UIScrollView * scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(0, 390);
    
    EDSOnlineAboutClassDetailAppointmentHeaderView *headerView = [[EDSOnlineAboutClassDetailAppointmentHeaderView alloc] init];
    headerView.model = self.model;
//    headerView.frame = CGRectMake(0, 0, kScreenWidth-30, 110);
    headerView.clipsToBounds = YES;
    UIView *bgView = [UIView new];
    bgView.hcCornerRadiusBlock(4, YES);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(15, 0, kScreenWidth-30, 390);
    self.headerView = headerView;
    [scrollView addSubview:bgView];
    [bgView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
//    if ([self.model.isAppointment isEqualToString:@"2"]) {
//
//        self.tableView.tableHeaderView.wz_size = CGSizeMake(kScreenWidth, 425+50);
//    }else{
//
//      self.tableView.tableHeaderView.wz_size = CGSizeMake(kScreenWidth, 425+50);
//    }
    
    EDSOnlineAboutClassDetailAppointmentDownView *downView = [[EDSOnlineAboutClassDetailAppointmentDownView alloc] init];
    downView.model = self.model;
    [self.view addSubview:downView];
    if ([self.model.isAppointment isEqualToString:@"2"]) {
        
        [downView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0);
        }];
    }else{
        
        [downView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(70);
        }];
    }
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(downView.mas_bottom);
    }];
}

- (void)setModel:(EDSOnlineClassListByDateModel *)model
{
    _model = model;
}

//#pragma mark ------------------------ tableView --------------------------------
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 2;
//}
//
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 1.确定重用标示:
//    static NSString *ID = @"EDSOnlineAboutClassDetailAppointmentTableViewCell";
//    // 2.从缓存池中取
//    EDSOnlineAboutClassDetailAppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    // 3.如果空就手动创建
//    if (!cell) {
//        cell = [[EDSOnlineAboutClassDetailAppointmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//    if (indexPath.row == 0) {
//
//        cell.present = self.model.present;
//
//    }else{
//
//        cell.present = [NSString stringWithFormat:@"预约的课程如因为其他原因不想预约，可以在课程开始前%@小时在我的课程记录中取消预约",self.model.advanceCancelHours];
//    }
//
//    return cell;
//}

@end
