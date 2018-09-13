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
    
    EDSOnlineAboutClassDetailAppointmentDownView *downView = [[EDSOnlineAboutClassDetailAppointmentDownView alloc] init];
    downView.model = self.model;
    [self.view addSubview:downView];
    [downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(70);
    }];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = ClearColor;
    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(downView.mas_top);
    }];
    
    
    EDSOnlineAboutClassDetailAppointmentHeaderView *headerView = [[EDSOnlineAboutClassDetailAppointmentHeaderView alloc] init];
    headerView.wz_size = CGSizeMake(kScreenWidth, 425);
    headerView.model = self.model;
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (void)setModel:(EDSOnlineClassListByDateModel *)model
{
    _model = model;
}

#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标示:
    static NSString *ID = @"EDSOnlineAboutClassDetailAppointmentTableViewCell";
    // 2.从缓存池中取
    EDSOnlineAboutClassDetailAppointmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[EDSOnlineAboutClassDetailAppointmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        cell.present = self.model.present;
        
    }else{
        
        cell.present = [NSString stringWithFormat:@"预约的课程如因为其他原因不想预约，可以在课程开始前%@小时在我的课程记录中取消预约",self.model.advanceCancelHours];
    }
    
    return cell;
}

@end
