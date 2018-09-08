//
//  EDSEorrorsViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/8.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSEorrorsViewController.h"

#import "EDSDataBase.h"

@interface EDSEorrorsViewController ()

@end

@implementation EDSEorrorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView  reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
