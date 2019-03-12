//
//  ComplaintViewController.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "ComplaintViewController.h"
#import "ComplaintTableViewCell.h"
#import "CRequest.h"

@interface ComplaintViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)NSArray *dataArr;
@property(nonatomic ,strong)NSArray *sectionList;
@end

@implementation ComplaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我要投诉";
    self.tableView.delegate = self;
    self.tableView.dataSource =  self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];

    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)requestData{
    CRequest *request = [CRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        self.dataArr = model;
        self.sectionList = responseDict[@"sectionList"];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failureBlock:^(NSError *error) {
          [self.tableView.mj_header endRefreshing];
    }];
    [request startRequest];
}

#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComplaintTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ComplaintTableViewCell"];
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"ComplaintTableViewCell" owner:self options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArr[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.backgroundColor = TableColor;
    label.text = [NSString stringWithFormat:@"   %@",self.sectionList[section]];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionList;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
