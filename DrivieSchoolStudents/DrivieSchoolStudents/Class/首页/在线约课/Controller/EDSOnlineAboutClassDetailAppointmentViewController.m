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
#import "LessonDetailsRequest.h"


#import "EDSOnlineClassListByDateModel.h"

@interface EDSOnlineAboutClassDetailAppointmentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) EDSOnlineAboutClassDetailAppointmentHeaderView *headerView;
@property (nonatomic , strong) MASConstraint* btnHeightConstraint;
@property (nonatomic , strong) EDSOnlineClassListByDateModel *model;
@property (nonatomic , strong) UIView *tipView;
@property (nonatomic , strong)  UILabel *tipLb;

@end

@implementation EDSOnlineAboutClassDetailAppointmentViewController
{
    EDSOnlineAboutClassDetailAppointmentHeaderView *headerView;
    EDSOnlineAboutClassDetailAppointmentDownView *downView;
    UIView *bgView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _isKe? @"我的课程": @"在线约课";
    
    
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
    scrollView.contentSize = CGSizeMake(0, 500);
    
    headerView = [[EDSOnlineAboutClassDetailAppointmentHeaderView alloc] init];
//    headerView.frame = CGRectMake(0, 0, kScreenWidth-30, 110);
    headerView.clipsToBounds = YES;
    bgView = [UIView new];
    bgView.hcCornerRadiusBlock(4, YES);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.frame = CGRectMake(15, 0, kScreenWidth-30, 410);
    self.headerView = headerView;
    [scrollView addSubview:bgView];
    [bgView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    downView = [[EDSOnlineAboutClassDetailAppointmentDownView alloc] init];
    downView.refreshBlock = ^{
        [self getData];
    };
    [self.view addSubview:downView];
    downView.clipsToBounds = YES;
    [downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        self.btnHeightConstraint = make.height.mas_equalTo(0);
    }];

    __weak EDSOnlineAboutClassDetailAppointmentDownView * weakDownView = downView;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(weakDownView.mas_bottom);
    }];
    downView.hidden = YES;
    headerView.hidden = YES;
    [self getData];
    
    self.tipView = [UIView new];
    _tipView.backgroundColor = RGBCOLOR(240, 231, 218);
    [scrollView addSubview:_tipView];
     __weak UIView * weakbgView = bgView;
    [_tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakbgView.mas_bottom).offset(15);
        make.left.mas_equalTo(30);
        make.width.mas_equalTo(kScreenWidth-60);
//        make.height.mas_equalTo(60);
    }];
    
   self.tipLb = [UILabel new];
   self.tipLb.numberOfLines = 0;
   [self.tipLb sizeToFit];
    self.tipLb.hcTextBlock([EDSToolClass getColorWithHexString:@"999999"], [UIFont systemFontOfSize:10], 1);
    [_tipView addSubview:self.tipLb];
    [self.tipLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-14);
    }];
    
    
}

- (void)setModel:(EDSOnlineClassListByDateModel *)model
{
    downView.hidden = NO;
    headerView.hidden = NO;
    _model = model;
    headerView.model = self.model;
    downView.model = self.model;
     if ([self.model.isAppointment isEqualToString:@"2"]) {
           [self.btnHeightConstraint setOffset:0];
     }else{
          [self.btnHeightConstraint setOffset:70];
     }
    
    if ([self.model.isAppointment isEqualToString:@"-1"]) {
        bgView.frame = CGRectMake(15, 0, kScreenWidth-30,  410);
    }else{
        bgView.frame = CGRectMake(15, 0, kScreenWidth-30, 440);
    }
   // advanceCancelHours
    _tipView.hidden = ![self.model.isAppointment isEqualToString:@"0"];
    self.tipLb.text = [NSString stringWithFormat:@"预约课程因为其他原因不想预约，也可以在课程开始前%@小时在“我的课程”或者“我的约课”中找到本节取消预约",model.advanceCancelHours];
}
    

- (void)getData
{
    MJWeakSelf
    LessonDetailsRequest *request = [LessonDetailsRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, EDSOnlineClassListByDateModel * model) {
        weakSelf.model = model;
    } failureBlock:^(NSError *error) {
    
    }];
    request.studentId = self.studentId;
    request.appointmentId = self.appointmentId;
    request.showHUD = YES;
    [request startRequest];
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
