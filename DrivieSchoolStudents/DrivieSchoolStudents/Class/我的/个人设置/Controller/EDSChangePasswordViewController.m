//
//  EDSChangePasswordViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSChangePasswordViewController.h"

#import "EDSStudentChangePassWordRequest.h"

@interface EDSChangePasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextF;
@property (weak, nonatomic) IBOutlet UITextField *againPasswordTextF;

@end

@implementation EDSChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改密码";
}


#pragma mark ---- 确认
- (IBAction)commitClick:(id)sender {
    
    BOOL isOldPSW = self.oldPasswordTextF.text.length > 0;
    BOOL isPSW = self.passwordTextF.text.length > 0;
    BOOL isAPSW = self.againPasswordTextF.text.length > 0 ;
    
    if (![self.passwordTextF.text isEqualToString:self.againPasswordTextF.text]) {
//        [SVProgressHUD showErrorWithStatus:@"俩次密码不一致"];
//        [SVProgressHUD dismissWithDelay:1.5];
        [self.view makeToast:@"俩次密码不一致"];
        return;
    }
    
    if (isOldPSW && isPSW && isAPSW) {
        
        EDSStudentChangePassWordRequest *request = [EDSStudentChangePassWordRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
            
            if (errCode == 1) {
                
                EDSAccount *account = [EDSSave account];
                account.userID = @"";
                [EDSSave save:account];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failureBlock:^(NSError *error) {
            
        }];
        request.password = self.passwordTextF.text;
        request.oldPassword = self.oldPasswordTextF.text;
        [request startRequest];
    }else{
        
//        [SVProgressHUD showErrorWithStatus:@"请输入完整信息"];
//        [SVProgressHUD dismissWithDelay:1.5];
        [self.view makeToast:@"请输入完整信息"];
        return;
    }
}

@end
