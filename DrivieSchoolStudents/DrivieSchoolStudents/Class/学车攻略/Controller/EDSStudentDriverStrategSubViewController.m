//
//  EDSStudentDriverStrategSubViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentDriverStrategSubViewController.h"

#import "EDSStudentDriverStrategSubTableViewCell.h"

#import "StudentDriverStrategConstants.h"

@interface EDSStudentDriverStrategSubViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation EDSStudentDriverStrategSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (id)initWithParentView:(UIViewController *)parentView controllerForTabAtIndex:(NSUInteger)index
{
    
    return self;
}

#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSStudentDriverStrategSubTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSStudentDriverStrategSubTableViewCell"];
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSStudentDriverStrategSubTableViewCell" owner:self options:nil].firstObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return StudentDriverStrategTableViewCellH;
}

@end
