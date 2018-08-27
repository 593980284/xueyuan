//
//  EDSSubscribeApplyViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSubscribeApplyViewController.h"

@interface EDSSubscribeApplyViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation EDSSubscribeApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"预约报名";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = ClearColor;
}


#pragma make ------ tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"UITableViewCell" owner:self options:nil].firstObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


@end
