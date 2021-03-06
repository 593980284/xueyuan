//
//  RegisterViewController.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/5.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "RegisterViewController.h"
#import "EDSLoginSettingsPasswordViewController.h"
#import "EDSMsgCodeRequest.h"
#import "RegisterRequest.h"
#import "SVProgressHUD.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwTF;

@end

@implementation RegisterViewController
- (IBAction)sendCodeBtnTap:(id)sender {
    
    if (self.phoneTF.text.length < 11) {
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
    request.phone = self.phoneTF.text;
    request.showHUD = YES;
    request.type = @"register";
    [request startRequest];
}
- (IBAction)nextBtnTap:(id)sender {
    if (_phoneTF.text.length != 11) {
        [self.view makeToast:@"请输入手机号" delay:2];
        return;
    }
    if (_pwTF.text.length == 0) {
        [self.view makeToast:@"请输入手机号" delay:2];
        return;
    }
    __weak typeof(self) weakSelf = self;
     [SVProgressHUD showWithStatus:@""];
    RegisterRequest * request = [RegisterRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
         [SVProgressHUD dismiss];
        if (errCode == 1) {
            EDSLoginSettingsPasswordViewController *vc = [EDSLoginSettingsPasswordViewController new];
            vc.phone = weakSelf.phoneTF.text;
            vc.isRegister = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [weakSelf.view makeToast:@"验证码错误" delay:2];
        }
    } failureBlock:^(NSError *error) {
         [SVProgressHUD dismiss];
        
    }];
    request.phone = _phoneTF.text;
    request.msgCode = _pwTF.text;
    request.step = 0;
    request.showHUD = YES;
    [request startRequest];
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
                self.sendCodeBtn.userInteractionEnabled = YES;
                [self.sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
               // [self.sendCodeBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
//                [self.sendCodeBtn setTitleColor:[EDSToolClass getColorWithHexString:@"#999999"] forState:UIControlStateNormal];
                self.sendCodeBtn.userInteractionEnabled = NO;
                
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self addNavigationBarLeftButtonItemWithInfo:[UIImage imageNamed:@"goback"] target:self action:@selector(goback)];
    self.sendCodeBtn.layer.cornerRadius = 4;
    self.sendCodeBtn.layer.borderColor = [EDSToolClass getColorWithHexString:@"#999999"].CGColor;
    self.sendCodeBtn.layer.borderWidth = 0.5;
}

- (void)goback{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
