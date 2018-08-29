//
//  EDSChangePhoneOneViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSChangePhoneOneViewController.h"

#import "EDSChangePhoneTwoViewController.h"

@interface EDSChangePhoneOneViewController ()

@end

@implementation EDSChangePhoneOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"跟换登录手机号";
}

- (IBAction)submitClick:(id)sender {
    
    EDSChangePhoneTwoViewController *vc = [[EDSChangePhoneTwoViewController alloc] initWithNibName:@"EDSChangePhoneTwoViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
