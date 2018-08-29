//
//  EDSPersonalSettingsViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSPersonalSettingsViewController.h"
#import "EDSChangePasswordViewController.h"//修改密码
#import "EDSChangePhoneOneViewController.h"//跟换手机号码

@interface EDSPersonalSettingsViewController ()
@property (weak, nonatomic) IBOutlet UIView *changePasswordBgview;
@property (weak, nonatomic) IBOutlet UIView *changephoneBgView;

@end

@implementation EDSPersonalSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人设置";
    
    @weakify(self);
    [self.changePasswordBgview bk_whenTapped:^{
        @strongify(self);
        EDSChangePasswordViewController *vc = [[EDSChangePasswordViewController alloc] initWithNibName:@"EDSChangePasswordViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.changephoneBgView bk_whenTapped:^{
        
        @strongify(self);
        EDSChangePhoneOneViewController *vc = [[EDSChangePhoneOneViewController alloc] initWithNibName:@"EDSChangePhoneOneViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}



@end
