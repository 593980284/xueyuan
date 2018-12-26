//
//  EDSCourseRecordDetailViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/31.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordDetailViewController.h"
#import "EDSCourseRecordCommentViewController.h"//评价
#import "EDSSeeEvaluationViewController.h"//查看评价

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
//    footerView.wz_size = CGSizeMake(kScreenWidth-40, 321+120);
    footerView.frame = CGRectMake(15, 0, kScreenWidth-30, 321+50);
    footerView.layer.cornerRadius = 5;
    footerView.clipsToBounds = YES;
    footerView.courseRecordModel = self.courseRecordModel;
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth , 321+50);
    [view addSubview:footerView];
    self.tableView.tableFooterView = view;
    
    
    EDSCourseRecordDetailDownView *downView = [[EDSCourseRecordDetailDownView alloc] init];
    [self.view addSubview:downView];
//    self.courseRecordModel.status = @"7";
//    self.courseRecordModel.coachScore = @"";
    downView.courseRecordModel = self.courseRecordModel;
    [downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(70);
    }];
    downView.courseRecordDetailDownViewDidButtonBackTitle = ^(NSString *title) {
        
        if ([title isEqualToString:@"立即评价"]) {
            
            EDSCourseRecordCommentViewController *vc = [[EDSCourseRecordCommentViewController alloc] initWithNibName:@"EDSCourseRecordCommentViewController" bundle:[NSBundle mainBundle]];
            vc.courseRecordModel = self.courseRecordModel;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //查看评价
            EDSSeeEvaluationViewController *vc = [[EDSSeeEvaluationViewController alloc] initWithNibName:@"EDSSeeEvaluationViewController" bundle:[NSBundle mainBundle]];
            vc.courseRecordModel = self.courseRecordModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
}


#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
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
