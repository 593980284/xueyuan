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

@interface EDSZXPracticeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *listArr;



@end

@implementation EDSZXPracticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"专项练习";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
    
    NSArray * titleArr = @[
                           @"文字题",@"图片题",@"动画题",@"判断题",
                           @"多选题",@"单选题",@"速度题",@"距离题",
                           @"标志题",@"手势题",@"信号题",@"酒驾题",
                           @"标线题",@"灯光题",@"装置题",@"路况题",
                           ];
    NSMutableArray * listArr = [NSMutableArray new];
    for (NSInteger index = 0; index < 4; index ++) {
        
        NSMutableArray * cellArr = [NSMutableArray new];
        for (NSInteger j = 0; j < 4; j++) {
            EDSTBPracticeModel * model = [EDSTBPracticeModel new];
            model.titleStr = titleArr[index * j];
            [cellArr addObject:model];
        }
        [listArr addObject:cellArr];
    }
    
    
    _listArr = [listArr copy];
    
    [self.tableView reloadData];

}

#pragma tableview --- delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EDSZXPracticeCell * cell = [EDSZXPracticeCell getCellWithId:@"EDSZXPracticeCell" andTableView:tableView];
    
    cell.btnClickBlock = ^(NSInteger clickType) {
        NSLog(@"点击了索引 %ld",clickType);
        switch (clickType) {
            case 0:
                
                break;
            case 1:
                
                break;
            case 2:
                
                break;
            case 3:
                
                break;
                
            default:
                break;
        }
    };
    
    return cell;
}
@end
