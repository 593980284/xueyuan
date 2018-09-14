//
//  EDSCourseRecordDetailViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/31.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordDetailViewController.h"
#import "EDSCourseRecordCommentViewController.h"//评价

#import "EDSCourseRecordDetailHeaderView.h"
#import "EDSCourseRecordDetailFooterView.h"
#import "EDSCourseRecordDetailDownView.h"

#import "EDSCourseRecordModel.h"

@interface EDSCourseRecordDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation EDSCourseRecordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"课程详情";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = ClearColor;
    
    EDSCourseRecordDetailHeaderView *headerView = [[EDSCourseRecordDetailHeaderView alloc] init];
    headerView.wz_size = CGSizeMake(kScreenWidth, 111);
    headerView.courseRecordModel = self.courseRecordModel;
    self.tableView.tableHeaderView = headerView;
    
    EDSCourseRecordDetailFooterView *footerView = [[EDSCourseRecordDetailFooterView alloc] init];
    footerView.wz_size = CGSizeMake(kScreenWidth, 321);
    footerView.courseRecordModel = self.courseRecordModel;
    self.tableView.tableFooterView = footerView;
    
    //        EDSCourseRecordCommentViewController *vc = [[EDSCourseRecordCommentViewController alloc] initWithNibName:@"EDSCourseRecordCommentViewController" bundle:[NSBundle mainBundle]];
    //        [self.navigationController pushViewController:vc animated:YES];
    
    EDSCourseRecordDetailDownView *downView = [[EDSCourseRecordDetailDownView alloc] init];
    [self.view addSubview:downView];
    [downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(70);
    }];
}


#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标示:
    static NSString *ID = @"UITableViewCell";
    // 2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1;
}
@end
