//
//  MyCoachViewController.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/2.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "MyCoachViewController.h"
#import "MyCoachTableViewCell.h"
#import "MyCoachRequest.h"
#import "ChangeCoachViewController.h"

@interface MyCoachViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)NSArray *dataArr;
@end

@implementation MyCoachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight - kNavigationH);
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCoachTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyCoachTableViewCell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    self.title = @"我的教练";
     [self.tableView.mj_header beginRefreshing];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//     [self.tableView.mj_header beginRefreshing];
//}

- (void)getData{
    @weakify(self);
    MyCoachRequest * request = [MyCoachRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        [weak_self.tableView.mj_header endRefreshing];
        weak_self.dataArr = model;
        [weak_self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        [weak_self.tableView.mj_header endRefreshing];
    }];
    request.phone = [EDSSave account].phone;
    [request startRequest];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCoachTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCoachTableViewCell" forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
     @weakify(self);
    cell.callBlock = ^(CoachModel *model) {
        if(model.coachPhone){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",model.coachPhone]]];
        }else{
            [weak_self.view makeToast:@"该教练没有预留手机号" delay:2];
        }
    };
    cell.changeApplyBlock = ^(CoachModel *model) {
        ChangeCoachViewController *vc = [ChangeCoachViewController new];
        vc.model = model;
        [weak_self.navigationController pushViewController:vc animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
