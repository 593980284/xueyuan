//
//  EDSLoginSettingsPasswordViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/25.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSLoginSettingsPasswordViewController.h"
#import "EDSAppTouristRegistRequest.h"
#import "EDSPSWLogoViewController.h"
#import <SVProgressHUD.h>
#import "RegisterRequest.h"
#import "EDSStudentLoginRequest.h"
#import "EDSAppStudentOperatingSystemRequest.h"


@interface EDSLoginSettingsPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pswTextF;
@property (weak, nonatomic) IBOutlet UITextField *againTextF;

@end

@implementation EDSLoginSettingsPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = WhiteColor;
    self.title = @"设置密码";
    [self addNavigationBarLeftButtonItemWithInfo:[UIImage imageNamed:@"goback"] target:self action:@selector(goback)];
}
- (void)goback{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)commitClik:(id)sender {
    
    if (self.pswTextF.text.length == 0 || self.againTextF.text.length == 0 ) {


        [self.view makeToast:@"请输入完整信息"];
        return ;
    }

    if (![self.pswTextF.text isEqualToString:self.againTextF.text] ) {

        [self.view makeToast:@"密码输入不一致"];

        return ;
    }
    
//    if (_isRegister) {
//        [self nextBtnTap:nil];
//        return;
//    }
    
    if (self.setType == LoginSetTypeRegister) {
        [self nextBtnTap:nil];
        return;
    }
    
//    if (self.setType == LoginSetTypeBindPhone) {//暂时不考虑新用户
//
//    }
    

    // LoginSetTypeSet
    [SVProgressHUD showWithStatus:@""];
    EDSAppTouristRegistRequest *request = [EDSAppTouristRegistRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        [SVProgressHUD dismiss];
        if (errCode == 1) {
            [self login];
            
        }
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
    request.phone = self.phone;
    request.password = self.pswTextF.text;
    request.showHUD = YES;
    [request startRequest];
}

- (void)login
{
    [SVProgressHUD showWithStatus:@""];
    EDSStudentLoginRequest *request = [EDSStudentLoginRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        [SVProgressHUD dismiss];
        if (errCode == 1) {
            [self appStudentOperatingSystem];
            [self dismissToRootViewController];
        }
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
    request.phone = self.phone;
    request.password = self.pswTextF.text;
    request.showHUD = YES;
    [request startRequest];
}

-(void)dismissToRootViewController  {
    UIViewController *vc = self;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
}

- (void)appStudentOperatingSystem
{
    EDSAppStudentOperatingSystemRequest *request = [EDSAppStudentOperatingSystemRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    request.phone = [EDSSave account].phone;
    request.operatingSystem = @"iOS";
    [request startRequest];
}

- (void)nextBtnTap:(id)sender {
    __weak typeof(self) weakSelf = self;
    [SVProgressHUD showWithStatus:@""];
    RegisterRequest * request = [RegisterRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        [SVProgressHUD dismiss];
        if (errCode == 1) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            [weakSelf.view makeToast:@"注册失败,请将密码设置为6位数以上字母或数字组合" delay:2];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
        
    }];
    request.phone = _phone;
    request.password = _pswTextF.text;
    request.step = 1;
    request.showHUD = YES;
    [request startRequest];
}

@end
