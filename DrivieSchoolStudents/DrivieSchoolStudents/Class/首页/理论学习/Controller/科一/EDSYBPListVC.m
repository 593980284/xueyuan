//
//  EDSTBListVC.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/29.
//  Copyright © 2018 班文政. All rights reserved.
//
//图标列表 controller
#import "EDSYBPListVC.h"
#import "EDSTBDetailListCell.h"

@interface EDSYBPListVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation EDSYBPListVC

- (void)viewDidLoad {
    [super viewDidLoad];
   self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = @"图标速记";
    
    // Do any additional setup after loading the view.
}

#pragma mark delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EDSTBDetailListCell * cell =  [EDSTBDetailListCell getCellWithId:@"EDSTBListCell" andTableView:tableView];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  130;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
