//
//  EDSTBListVC.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/29.
//  Copyright © 2018 班文政. All rights reserved.
//
//图标列表 controller
#import "EDSTBListVC.h"
#import "EDSTBListCell.h"
#import "EDSYBPListVC.h"
#import "EDSTBPracticeModel.h"

@interface EDSTBListVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *listArr;

@end

@implementation EDSTBListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = @"图标速记";
    
//    return listArr;
    
    // Do any additional setup after loading the view.
}

#pragma mark delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return  _listArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EDSTBListCell * cell =  [EDSTBListCell getCellWithId:@"EDSTBListCell" andTableView:tableView];
    cell.model = _listArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EDSYBPListVC *vc = [EDSYBPListVC new];
    [self.navigationController pushViewController:vc animated:YES];
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
