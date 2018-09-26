//
//  EDSPSWLogoViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSPSWLogoViewController.h"
#import "EDSLoginSettingsPasswordViewController.h"
#import <IQKeyboardManager.h>

#import "EDSMsgCodeLoginRequest.h"
#import "EDSStudentLoginRequest.h"
#import "EDSMsgCodeRequest.h"
#import "EDSStudentLoginRequest.h"
#import "EDSAppStudentOperatingSystemRequest.h"

@interface EDSPSWLogoViewController ()
{
    BOOL _isCodeLogin;
}
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UIButton *pswBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (strong, nonatomic) UIView *indicatorView;

@property (weak, nonatomic) IBOutlet UIView *codeLoginBgView;
@property (weak, nonatomic) IBOutlet UITextField *codePhoneTextF;
@property (weak, nonatomic) IBOutlet UITextField *codeVerificationTextF;

@property (weak, nonatomic) IBOutlet UIView *pswLoginBgView;
@property (weak, nonatomic) IBOutlet UITextField *pswPhoneTextF;
@property (weak, nonatomic) IBOutlet UITextField *pswCodeTextF;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;

@end

@implementation EDSPSWLogoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.codePhoneTextF.text = @"18297982132";
//    self.pswPhoneTextF.text = @"18297982132";
    
    self.pswBtn.selected = YES;
    self.pswLoginBgView.hidden = NO;
    self.codeLoginBgView.hidden = YES;
    _isCodeLogin = NO;
    
    self.indicatorView = [UIView viewWithBackgroundColor:ThemeColor superView:self.view];
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 2));
        make.left.mas_equalTo(KLineX(81));
        make.bottom.mas_equalTo(self.lineView.mas_top);
    }];
    @weakify(self);
    [self.pswBtn bk_whenTapped:^{
        @strongify(self);
        
        self.pswBtn.selected = YES;
        self.codeBtn.selected = NO;
        self.pswLoginBgView.hidden = NO;
        self.codeLoginBgView.hidden = YES;
        self->_isCodeLogin = NO;
        
        [self.indicatorView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(KLineX(81));
        }];
    }];
    [self.codeBtn bk_whenTapped:^{
        @strongify(self);
        
        self.pswBtn.selected = NO;
        self.codeBtn.selected = YES;
        self.pswLoginBgView.hidden = YES;
        self.codeLoginBgView.hidden = NO;
        self->_isCodeLogin = YES;
        
        [self.indicatorView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kScreenWidth - KLineX(85-50));
        }];
    }];
    
}
- (IBAction)getCodeClick:(id)sender {
    
    if (self.codePhoneTextF.text.length < 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        [SVProgressHUD dismissWithDelay:1.5];
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
    request.phone = self.codePhoneTextF.text;
    [request startRequest];
}


- (IBAction)loginClick:(id)sender {
    
    if (_isCodeLogin) {
        //验证码登录
        BOOL isPhone = self.codePhoneTextF.text.length > 10;
        BOOL isPSW = self.codeVerificationTextF.text.length > 0;
        
        if (isPSW && isPhone) {
            EDSMsgCodeLoginRequest *request = [EDSMsgCodeLoginRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
                
                [self appStudentOperatingSystem];
                
                if (errCode == 1) {
                    
                    if ([[EDSSave account].state isEqual:@"1"] && [[EDSSave account].touristState isEqual:@"0"]) {
                        
                        EDSLoginSettingsPasswordViewController *vc = [[EDSLoginSettingsPasswordViewController alloc] initWithNibName:@"EDSLoginSettingsPasswordViewController" bundle:[NSBundle mainBundle]];
                        [self.navigationController presentViewController:vc animated:YES completion:^{
                            
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }];
                    }else{
                        
                        [self  dismissViewControllerAnimated:YES completion:nil];
                    }
                }
                
            } failureBlock:^(NSError *error) {
                
            }];
            request.phone = self.codePhoneTextF.text;
            request.msgCode = self.codeVerificationTextF.text;
            [request startRequest];
        }else{
            [SVProgressHUD showErrorWithStatus:@"请输入完整信息"];
            [SVProgressHUD dismissWithDelay:1.5];
            return;
        }
        
    }else{
        //密码登录
        BOOL isPhone = self.pswPhoneTextF.text.length > 10;
        BOOL isPWS = self.pswCodeTextF.text.length > 0;
        
        if (isPWS && isPhone) {
            
            EDSStudentLoginRequest *request = [EDSStudentLoginRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
                
                if (errCode == 1) {
                    [self appStudentOperatingSystem];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                
            } failureBlock:^(NSError *error) {
                
            }];
            request.phone = self.pswPhoneTextF.text;
            request.password = self.pswCodeTextF.text;
            [request startRequest];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"请输入完整信息"];
            [SVProgressHUD dismissWithDelay:1.5];
            return;
            
        }
    }
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
                self.getCodeBtn.userInteractionEnabled = YES;
                [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.getCodeBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.getCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.getCodeBtn setTitleColor:[EDSToolClass getColorWithHexString:@"#999999"] forState:UIControlStateNormal];
                self.getCodeBtn.userInteractionEnabled = NO;
                
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

@end
