//
//  EDSOnlineAboutClassDetailAppointmentDownView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineAboutClassDetailAppointmentDownView.h"

#import "EDSOnlineClassListByDateModel.h"
#import "EDSStudentAppointmentRequest.h"

@interface EDSOnlineAboutClassDetailAppointmentDownView ()

@property (nonatomic , strong) UIButton *determineBtn;      //确认预约
@property (nonatomic , strong) UIButton *signinBtn;         //课程签到
@property (nonatomic , strong) UIButton *canleBtn;          //取消预约
@property (nonatomic , strong) UIButton *alreadySignIn;     //已签到
@property (nonatomic , strong) NSTimer * timer;

@end

@implementation EDSOnlineAboutClassDetailAppointmentDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

- (void)setModel:(EDSOnlineClassListByDateModel *)model
{
//      model.isAppointment = @"0";
//      model.periodTime = @"2018-11-26 21:15-23:15";
//      model.shortPeriodTime = @"21:15-22:15";
    _model = model;
    //是否预约 -1未预约 0已预约 1已签到
    if ([model.isAppointment isEqualToString:@"-1"] && ![model.noAppointmentNum isEqualToString:@"0"]) {
        
        self.determineBtn.hidden = NO;
        self.signinBtn.hidden = YES;
        self.canleBtn.hidden = YES;
        self.alreadySignIn.hidden = YES;
        
    }else if([model.isAppointment isEqualToString:@"1"]){
        
        self.determineBtn.hidden = YES;
        self.signinBtn.hidden = YES;
        self.canleBtn.hidden = YES;
        self.alreadySignIn.hidden = NO;
    }else if([model.isAppointment isEqualToString:@"0"]){
        self.determineBtn.hidden = YES;
        self.signinBtn.hidden = NO;
        self.canleBtn.hidden = NO;
        self.alreadySignIn.hidden = YES;
        [self beginTimer];// 开启定时器
    }else{
        
        self.determineBtn.hidden = YES;
        self.signinBtn.hidden = YES;
        self.canleBtn.hidden = YES;
        self.alreadySignIn.hidden = YES;
    }
    //确认预约
    @weakify(self);
    [self.determineBtn bk_whenTapped:^{
        
        @strongify(self);
        
        EDSStudentAppointmentRequest *request = [EDSStudentAppointmentRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model1) {
            
            if (errCode == 1) {
                self.refreshBlock();
                self.signinBtn.hidden = NO;
                self.canleBtn.hidden = NO;
                self.determineBtn.hidden = YES;
                self.alreadySignIn.hidden = YES;
                
                if ([self judgeTimeByStartAndEnd:model.startSiginDate withExpireTime:model.endSiginDate]) {
                    
                    self.signinBtn.enabled = YES;
                    self.signinBtn.backgroundColor = ThemeColor;
                }else{
                    
                    self.signinBtn.enabled = NO;
                    self.signinBtn.backgroundColor = ThirdColor;
                }
            }
        } failureBlock:^(NSError *error) {
            
        }];
        request.schoolId = model.schoolId;
        request.appointmentId = model.appointmentId;
        request.studentId = model.studentId;
        request.status = @"0";
        request.showHUD = YES;
        [request  startRequest];
    }];
    //课程签到
    [self.signinBtn bk_whenTapped:^{
        
        @strongify(self);
        EDSStudentAppointmentRequest *request = [EDSStudentAppointmentRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
            self.refreshBlock();
            if (errCode == 1) {
                self.refreshBlock();
                self.determineBtn.hidden = YES;
                self.signinBtn.hidden = YES;
                self.canleBtn.hidden = YES;
                self.alreadySignIn.hidden = NO;
            }
        } failureBlock:^(NSError *error) {
            
        }];
        request.schoolId = model.schoolId;
        request.appointmentId = model.appointmentId;
        request.studentId = model.studentId;
        request.status = @"1";
        request.showHUD = YES;
        [request  startRequest];
    }];
    //取消预约
    [self.canleBtn bk_whenTapped:^{
        @strongify(self);
        // 手机当前时间
        NSDate *nowDate = [NSDate date];
        // 获得比较结果(谁大谁小)
        NSComparisonResult result = [nowDate compare:model.cancleAppDate];
        if (result == NSOrderedAscending) { // 升序, 越往右边越大
            
            UIAlertController *alerController = [UIAlertController alertControllerWithTitle:nil message:@"是否确定取消本次预约？" preferredStyle:UIAlertControllerStyleAlert];UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                EDSStudentAppointmentRequest *request = [EDSStudentAppointmentRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
                    
                    if (errCode == 1) {
                        self.refreshBlock();
                        self.determineBtn.hidden = NO;
                        self.signinBtn.hidden = YES;
                        self.canleBtn.hidden = YES;
                        self.alreadySignIn.hidden = YES;
                    }
                } failureBlock:^(NSError *error) {
                    
                }];
                request.schoolId = model.schoolId;
                request.appointmentId = model.appointmentId;
                request.studentId = model.studentId;
                request.status = @"10";
                request.showHUD = YES;
                [request startRequest];
                
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alerController addAction:okAction];
            [alerController addAction:cancelAction];
            [[self getCurrentVC] presentViewController:alerController animated:YES completion:nil];
        }else{
            [[self currentViewController].view makeToast:@"可取消时间已过"];
        }
    }];
}

//当前时间是否在时间段内
- (BOOL)judgeTimeByStartAndEnd:(NSDate *)startTime withExpireTime:(NSDate *)expireTime {
    NSDate *today = [NSDate date];
    
    if ([today compare:startTime] == NSOrderedDescending && [today compare:expireTime] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}



- (UIButton *)determineBtn
{
    if (!_determineBtn) {
        
        _determineBtn = [[UIButton alloc] init];
        [_determineBtn setTitle:@"确认预约" forState:UIControlStateNormal];
        _determineBtn.enabled = YES;
        [_determineBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _determineBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _determineBtn.backgroundColor = ThemeColor;
        _determineBtn.layer.cornerRadius = 5;
        _determineBtn.layer.masksToBounds = YES;
        [self addSubview:_determineBtn];
        [_determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(45);
            make.bottom.mas_equalTo(-18);
        }];
    }
    return _determineBtn;
}

- (UIButton *)alreadySignIn
{
    if (!_alreadySignIn) {
        
        _alreadySignIn = [[UIButton alloc] init];
        [_alreadySignIn setTitle:@"已签到" forState:UIControlStateNormal];
        _alreadySignIn.enabled = NO;
        [_alreadySignIn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _alreadySignIn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _alreadySignIn.backgroundColor = ThirdColor;
        _alreadySignIn.layer.cornerRadius = 5;
        _alreadySignIn.layer.masksToBounds = YES;
        [self addSubview:_alreadySignIn];
        [_alreadySignIn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(45);
            make.bottom.mas_equalTo(-18);
        }];
    }
    return _alreadySignIn;
}

- (UIButton *)signinBtn
{
    if (!_signinBtn) {
        
        _signinBtn = [[UIButton alloc] init];
        [_signinBtn setTitle:@"课程签到" forState:UIControlStateNormal];
        [_signinBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _signinBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _signinBtn.backgroundColor = ThirdColor;
        _signinBtn.layer.cornerRadius = 5;
        _signinBtn.layer.masksToBounds = YES;
        [self addSubview:_signinBtn];
        [_signinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.height.mas_equalTo(45);
            make.width.mas_equalTo((kScreenWidth - 15*3)*0.5);
            make.bottom.mas_equalTo(-15);
        }];
    }
    return _signinBtn;
}

- (UIButton *)canleBtn
{
    if (!_canleBtn) {
        
        _canleBtn = [[UIButton alloc] init];
        [_canleBtn setTitle:@"取消预约" forState:UIControlStateNormal];
        [_canleBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _canleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _canleBtn.backgroundColor = ThemeColor;
        _canleBtn.layer.cornerRadius = 5;
        _canleBtn.layer.masksToBounds = YES;
        [self addSubview:_canleBtn];
        [_canleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(45);
            make.width.mas_equalTo((kScreenWidth - 15*3)*0.5);
            make.bottom.mas_equalTo(-15);
        }];
    }
    return _canleBtn;
}



- (UIViewController*)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal)
    {
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                
                break
                ;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        
        result = nextResponder;
    
    else
        
        result = window.rootViewController;
    
    return result;
}

/** 定时器相关*/

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)beginTimer{
    [self stopTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handletimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer: self.timer forMode:NSRunLoopCommonModes];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [self stopTimer];
    }
}

- (void)handletimer{
    
    if ([self judgeTimeByStartAndEnd:_model.startSiginDate withExpireTime:_model.endSiginDate]) {
        
        self.signinBtn.enabled = YES;
        self.signinBtn.backgroundColor = ThemeColor;
    }else{
        self.signinBtn.enabled = NO;
        self.signinBtn.backgroundColor = ThirdColor;
        if ([[NSDate new] compare:_model.endSiginDate] == NSOrderedDescending) {
            [self stopTimer];
        }
    }
    
}
@end
