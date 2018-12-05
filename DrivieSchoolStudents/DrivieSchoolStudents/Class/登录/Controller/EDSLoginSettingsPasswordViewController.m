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
    
    if (_isRegister) {
        [self nextBtnTap:nil];
        return;
    }

    [SVProgressHUD showWithStatus:@""];
    EDSAppTouristRegistRequest *request = [EDSAppTouristRegistRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        [SVProgressHUD dismiss];
        if (errCode == 1) {
            
            EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] initWithNibName:@"EDSPSWLogoViewController" bundle:[NSBundle mainBundle]];
            [self presentViewController:vc animated:YES completion:nil];
        }
        
    } failureBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
    request.phone = self.phone;
    request.password = self.pswTextF.text;
    request.showHUD = YES;
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
