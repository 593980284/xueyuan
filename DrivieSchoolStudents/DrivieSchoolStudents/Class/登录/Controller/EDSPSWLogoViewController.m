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
#import "EDSYHXYViewController.h"
#import <SVProgressHUD.h>

#import "EDSMsgCodeLoginRequest.h"
#import "EDSStudentLoginRequest.h"
#import "EDSMsgCodeRequest.h"
#import "EDSStudentLoginRequest.h"
#import "EDSAppStudentOperatingSystemRequest.h"
#import "RegisterViewController.h"
#import <UMShare/UMShare.h>

@interface EDSPSWLogoViewController ()
{
    BOOL _isCodeLogin;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBtnBottonHeight;

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
- (IBAction)gotoRegister:(id)sender {
    RegisterViewController* vc = [RegisterViewController new];
    UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:vc];
      [self presentViewController:navi animated:YES completion:nil];
}
- (IBAction)goback:(id)sender {
    AppDelegate* d= (AppDelegate*)[UIApplication sharedApplication].delegate;
    UITabBarController * vc = (UITabBarController *)d.window.rootViewController;
    vc.selectedIndex = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)seeDelegate:(id)sender {
    EDSYHXYViewController *vc = [[EDSYHXYViewController alloc] initWithNibName:@"EDSYHXYViewController" bundle:[NSBundle mainBundle]];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = WhiteColor;
    self.loginBtnBottonHeight.constant = KLineY(100);
    self.lineView.hidden = YES;
    self.pswBtn.hidden = YES;
    self.pswBtn.selected = NO;
    self.indicatorView.hidden = YES;
    
#ifdef DEBUG
    self.codePhoneTextF.text = @"15848500805";
    self.pswPhoneTextF.text =  @"15848500805";
#else
#endif
    self.pswLoginBgView.hidden = NO;
    self.codeLoginBgView.hidden = YES;
    _isCodeLogin = NO;
    
//    self.indicatorView = [UIView viewWithBackgroundColor:ThemeColor superView:self.view];
//    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(50, 2));
//        make.left.mas_equalTo(self.pswBtn.wz_centerX - 50);
//        make.bottom.mas_equalTo(self.lineView.mas_top);
//    }];
    @weakify(self);
    [self.pswBtn bk_whenTapped:^{
        @strongify(self);
        
        self.pswBtn.hidden = YES;
        self.codeBtn.hidden = NO;
        self.pswLoginBgView.hidden = NO;
        self.codeLoginBgView.hidden = YES;
        self->_isCodeLogin = NO;
        
        [self.indicatorView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pswBtn.wz_centerX - 25);
        }];
    }];
    [self.codeBtn bk_whenTapped:^{
        @strongify(self); 
        
        self.pswBtn.hidden = NO;
        self.codeBtn.hidden = YES;
        self.pswLoginBgView.hidden = YES;
        self.codeLoginBgView.hidden = NO;
        self->_isCodeLogin = YES;
        
        [self.indicatorView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.codeBtn.wz_centerX - 25);
        }];
    }];
    
}
- (IBAction)getCodeClick:(id)sender {
    
    if (self.codePhoneTextF.text.length < 11) {
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
    request.phone = self.codePhoneTextF.text;
    request.showHUD = YES;
    [request startRequest];
}
- (IBAction)sinaBtnClick:(id)sender {
	
	
}

- (IBAction)qqBtnClick:(id)sender {
	[self getUserInfoForPlatform:UMSocialPlatformType_QQ];
}

- (IBAction)wxBtnClick:(id)sender {
}

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
	[[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
		UMSocialUserInfoResponse *resp = result;
		// 第三方登录数据(为空表示平台未提供)
		// 授权数据
		NSLog(@" uid: %@", resp.uid);
		NSLog(@" openid: %@", resp.openid);
		NSLog(@" accessToken: %@", resp.accessToken);
		NSLog(@" refreshToken: %@", resp.refreshToken);
		NSLog(@" expiration: %@", resp.expiration);
		// 用户数据
		NSLog(@" name: %@", resp.name);
		NSLog(@" iconurl: %@", resp.iconurl);
		NSLog(@" gender: %@", resp.unionGender);
		// 第三方平台SDK原始数据
		NSLog(@" originalResponse: %@", resp.originalResponse);
	}];
}
- (IBAction)loginClick:(id)sender {
//
//    if (!self.userAgreementBtn.selected) {
//
//        [self.view makeToast:@"请先同意用户协议"];
//        return;
//    }
    
    if (_isCodeLogin) {
        //验证码登录
        BOOL isPhone = self.codePhoneTextF.text.length > 10;
        BOOL isPSW = self.codeVerificationTextF.text.length > 0;
        
        if (isPSW && isPhone) {
            
            [SVProgressHUD showWithStatus:@""];
            EDSMsgCodeLoginRequest *request = [EDSMsgCodeLoginRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
                
                [self appStudentOperatingSystem];
                [SVProgressHUD dismiss];
                
                if (errCode == 1) {
                    
                    if ([[NSString stringWithFormat:@"%@",[EDSSave account].state] isEqualToString:@"1"] && [[NSString stringWithFormat:@"%@",[EDSSave account].touristState] isEqualToString:@"0"]) {
                        
                        EDSLoginSettingsPasswordViewController *vc = [[EDSLoginSettingsPasswordViewController alloc] initWithNibName:@"EDSLoginSettingsPasswordViewController" bundle:[NSBundle mainBundle]];
                        vc.phone = self.pswPhoneTextF.text;
                        [self presentViewController:vc animated:YES completion:nil];
                        
                    }else{
                        
                        [self dismissToRootViewController];
                    }
                }
                
            } failureBlock:^(NSError *error) {
                [SVProgressHUD dismiss];
            }];
            request.phone = self.codePhoneTextF.text;
            request.msgCode = self.codeVerificationTextF.text;
            request.showHUD = YES;
            [request startRequest];
        }else{
//            [SVProgressHUD showErrorWithStatus:@"请输入完整信息"];
//            [SVProgressHUD dismissWithDelay:1.5];
            [self.view makeToast:@"请输入完整信息"];
            return;
        }
        
    }else{
        //密码登录
        BOOL isPhone = self.pswPhoneTextF.text.length > 10;
        BOOL isPWS  = self.pswCodeTextF.text.length > 0;
        
        if (isPWS && isPhone) {
            
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
            request.phone = self.pswPhoneTextF.text;
            request.password = self.pswCodeTextF.text;
            request.showHUD = YES;
            [request startRequest];
        }else
        {
            [self.view makeToast:@"请输入完整信息"];
            return;
            
        }
    }
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
