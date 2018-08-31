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
    self.tableView.tableHeaderView = headerView;
    
    EDSCourseRecordDetailFooterView *footerView = [[EDSCourseRecordDetailFooterView alloc] init];
    footerView.wz_size = CGSizeMake(kScreenWidth, 321);
    self.tableView.tableFooterView = footerView;
    
    UIButton *determineBtn = [[UIButton alloc] init];
    [determineBtn setTitle:@"评价" forState:UIControlStateNormal];
    [determineBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    determineBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    determineBtn.backgroundColor = ThemeColor;
    determineBtn.layer.cornerRadius = 5;
    determineBtn.layer.masksToBounds = YES;
    [self.view addSubview:determineBtn];
    [determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(-18);
    }];
    @weakify(self);
    [determineBtn bk_whenTapped:^{
        @strongify(self);
        EDSCourseRecordCommentViewController *vc = [[EDSCourseRecordCommentViewController alloc] initWithNibName:@"EDSCourseRecordCommentViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
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
