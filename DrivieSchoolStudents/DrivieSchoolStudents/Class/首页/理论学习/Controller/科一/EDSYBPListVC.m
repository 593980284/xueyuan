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
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    [self.tableView reloadData];
}
#pragma mark delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    if (_dataArr.count % 2 == 0) {
        return _dataArr.count/2;
    }else{
        return _dataArr.count/2 + 1;
    }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSDictionary *dic1 =  _dataArr[indexPath.row * 2];
    NSDictionary  *dic2 ;
    if (_dataArr.count >  indexPath.row * 2 + 1 ) {
       dic2 =  _dataArr[indexPath.row * 2 +1];
    }
    EDSTBDetailListCell * cell =  [EDSTBDetailListCell getCellWithId:@"EDSTBListCell" andTableView:tableView];
    cell.firstTilteLabel.text = dic1[@"title"];
    cell.firstImagV.image = [UIImage imageNamed:dic1[@"icon"]];
    
    if (dic2) {
        cell.secTitleLabel.text = dic2[@"title"];
        cell.secImagV.image = [UIImage imageNamed:dic2[@"icon"]];
    }
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
