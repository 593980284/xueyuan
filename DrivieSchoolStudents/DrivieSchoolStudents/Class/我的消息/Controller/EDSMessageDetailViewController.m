//
//  EDSMessageDetailViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/4.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSMessageDetailViewController.h"

#import "EDSMessageDetailTableViewCell.h"

@interface EDSMessageDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation EDSMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的消息";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标示:
    static NSString *ID = @"EDSMessageDetailTableViewCell";
    // 2.从缓存池中取
    EDSMessageDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[EDSMessageDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        cell.isQuestion = YES;
    }else
    {
        cell.isQuestion = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
@end
