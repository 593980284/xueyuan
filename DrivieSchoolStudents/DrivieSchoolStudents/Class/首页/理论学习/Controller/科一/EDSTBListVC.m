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

#import "EDSTBJQDataBase.h"

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
    
    
    
//    1 3  7 4 6 4 8  2道路图标  14 汽车仪表 15 车内功能按键 17交通事故
//    NSArray * tubiaoArr = [[EDSTBJQDataBase sharedDataBase]getTuBiaoWithCid:1 andlimit:4];
//    NSLog(@"%@",tubiaoArr);
    
   NSArray * daoluArr = [[EDSTBJQDataBase sharedDataBase]getDaoLuTuBaio];
   NSArray * yibiaoArr =  [[EDSTBJQDataBase sharedDataBase]getQiCheYiBiao];
  NSArray * gongnengjianArr =   [[EDSTBJQDataBase sharedDataBase]getCheNeiGongNengJian];
  NSArray * jiaotongshigu =   [[EDSTBJQDataBase sharedDataBase]getJiaoTongShiGu];
    _listArr = @[
                 @{
                     @"title":@"交通标志大全",
                     @"arr":daoluArr,
                     },
                 @{
                     @"title":@"汽车仪表盘指示灯",
                     @"arr":yibiaoArr,
                     },
                 @{
                     @"title":@"车内功能按键",
                     @"arr":gongnengjianArr,
                     },
                 @{
                     @"title":@"交通事故图解",
                     @"arr":jiaotongshigu,
                     }
                ];
    
    [self.tableView reloadData];
    
//    return listArr;
    
    // Do any additional setup after loading the view.
}

#pragma mark delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return  _listArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EDSTBListCell * cell =  [EDSTBListCell getCellWithId:@"EDSTBListCell" andTableView:tableView];
    cell.dataDic = _listArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EDSYBPListVC *vc = [EDSYBPListVC new];
    
    vc.dataArr = _listArr[indexPath.row][@"arr"];
    
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
