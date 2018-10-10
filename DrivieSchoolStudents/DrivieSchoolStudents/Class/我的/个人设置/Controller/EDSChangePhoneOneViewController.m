//
//  EDSChangePhoneOneViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSChangePhoneOneViewController.h"

#import "EDSChangePhoneTwoViewController.h"

#import "EDSMsgCodeRequest.h"
#import "EDSStudentCheckOldPhoneRequest.h"

@interface EDSChangePhoneOneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UITextField *codeTextF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@end

@implementation EDSChangePhoneOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"跟换登录手机号";
}

- (IBAction)codeBtnClick:(id)sender {
    
    if (self.phoneTextF.text.length < 11) {
//        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
//        [SVProgressHUD dismissWithDelay:1.5];
        [self.view makeToast:@"请输入正确的手机号码"];
        return;
    }
    
    UIButton *buttone = sender;
    buttone.userInteractionEnabled = NO;
    
    EDSMsgCodeRequest *request = [EDSMsgCodeRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            
            [self openCountdown];
            
            buttone.userInteractionEnabled = NO;
        }else{
            
            buttone.userInteractionEnabled = YES;
        }
    } failureBlock:^(NSError *error) {
        
        buttone.userInteractionEnabled = YES;
    }];
    
    request.phone = self.phoneTextF.text;
    
    [request startRequest];
}

- (IBAction)submitClick:(id)sender {
    
    if (self.phoneTextF.text.length > 0 && self.codeTextF.text.length > 0) {
        
        @weakify(self);
        EDSStudentCheckOldPhoneRequest *request = [EDSStudentCheckOldPhoneRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
            @strongify(self);
            
            if (errCode == 1) {
                
                EDSChangePhoneTwoViewController *vc = [[EDSChangePhoneTwoViewController alloc] initWithNibName:@"EDSChangePhoneTwoViewController" bundle:[NSBundle mainBundle]];
                [self.navigationController pushViewController:vc animated:YES];
            }

        } failureBlock:^(NSError *error) {
        
        }];
        request.phone = self.phoneTextF.text;
        request.msgCode = self.codeTextF.text;
        [request startRequest];
    }else{
//        [SVProgressHUD showErrorWithStatus:@"请输入完整信息"];
//        [SVProgressHUD dismissWithDelay:1.5];
        [self.view makeToast:@"请输入完整信息"];
    }
}



// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    @weakify(self);
    
    dispatch_source_set_event_handler(_timer, ^{
        
        @strongify(self);
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                self.codeBtn.userInteractionEnabled = YES;
                [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.codeBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.codeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.codeBtn setTitleColor:[EDSToolClass getColorWithHexString:@"#999999"] forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = NO;
                
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

@end
