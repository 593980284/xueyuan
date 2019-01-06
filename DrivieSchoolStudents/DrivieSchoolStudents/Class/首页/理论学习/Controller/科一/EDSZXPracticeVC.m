//
//  EDSZXPracticeVC.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/29.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSZXPracticeVC.h"
#import "EDSZXPracticeCell.h"
#import "EDSTBPracticeModel.h"

//#import "EDSPracticeViewController.h"
#import "EDSPracticeViewController.h"

@interface EDSZXPracticeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *listArr;



@end

@implementation EDSZXPracticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"专项练习";
     self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
    
    _listArr = @[
                             @{
                               @"title":@[@"文字题",@"图片题",@"动画题",@"判断题"],
                               @"img":@[@"ZX_list_1",@"ZX_list_2",@"ZX_list_3",@"ZX_list_4"]
                               },
                             @{
                                 @"title":@[@"多选题",@"单选题",@"速度题",@"距离题"],
                                 @"img":@[@"ZX_list_5",@"ZX_list_6",@"ZX_list_7",@"ZX_list_8"]
                                 },
                             @{
                                 @"title":@[@"标志题",@"手势题",@"信号题",@"酒驾题"],
                                 @"img":@[@"ZX_list_9",@"ZX_list_10",@"ZX_list_11",@"ZX_list_12"]
                                 },
                             @{
                                @"title":@[@"标线题",@"灯光题",@"装置题",@"路况题"],
                                @"img":@[@"ZX_list_13",@"ZX_list_14",@"ZX_list_15",@"ZX_list_16"]
                                 },
                             
                           ];
//    NSMutableArray * listArr = [NSMutableArray new];
//    for (NSInteger index = 0; index < 4; index ++) {
//
//        NSMutableArray * cellArr = [NSMutableArray new];
//        for (NSInteger j = 0; j < 4; j++) {
//            EDSTBPracticeModel * model = [EDSTBPracticeModel new];
//            model.titleStr = titleArr[index * j];
//            [cellArr addObject:model];
//        }
//        [listArr addObject:cellArr];
//    }
    
    
//    _listArr = [listArr copy];
    
    [self.tableView reloadData];

}

#pragma tableview --- delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EDSZXPracticeCell * cell = [EDSZXPracticeCell getCellWithId:@"EDSZXPracticeCell" andTableView:tableView];
    
    cell.dataDic = _listArr[indexPath.row];
    
    cell.btnClickBlock = ^(NSInteger clickType) {
        NSLog(@"点击了索引 %ld",clickType);
         EDSPracticeViewController *vc = [[EDSPracticeViewController alloc] init];
        switch (clickType) {
            case 0:
                vc.type = indexPath.row * 4 + 2;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            case 1:
                vc.type = indexPath.row * 4 + 3;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            case 2:
                vc.type = indexPath.row * 4 + 4;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            case 3:
                
                vc.type = indexPath.row * 4 + 5;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            default:
                break;
        }
    };
    
    return cell;
}
@end
