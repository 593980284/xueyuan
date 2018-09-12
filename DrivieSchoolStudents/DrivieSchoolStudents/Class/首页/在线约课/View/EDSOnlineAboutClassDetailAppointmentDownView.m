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

@property (nonatomic , strong) UIButton *determineBtn;//确认预约
@property (nonatomic , strong) UIButton *signinBtn;//课程签到
@property (nonatomic , strong) UIButton *canleBtn;//取消预约

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
    _model = model;
    
    //    是否预约 -1未预约 0已预约 1已签到
    if ([model.isAppointment isEqualToString:@"-1"]) {
        
        self.determineBtn.hidden = NO;
        self.signinBtn.hidden = YES;
        self.canleBtn.hidden = YES;
        @weakify(self);
        [self.determineBtn bk_whenTapped:^{
            @strongify(self);
            
            EDSStudentAppointmentRequest *request = [EDSStudentAppointmentRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
                
            } failureBlock:^(NSError *error) {
                
            }];
            request.schoolId = model.schoolId;
            request.appointmentId = model.appointmentId;
            request.studentId = [EDSSave account].userID;
            request.status = @"0";
            [request  startRequest];
        }];
    }else{
        
        self.determineBtn.hidden = YES;
        self.signinBtn.hidden = NO;
        self.canleBtn.hidden = NO;
        
        [self.signinBtn bk_whenTapped:^{
            
            EDSStudentAppointmentRequest *request = [EDSStudentAppointmentRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
                
            } failureBlock:^(NSError *error) {
                
            }];
            request.schoolId = model.schoolId;
            request.appointmentId = model.appointmentId;
            request.studentId = [EDSSave account].userID;
            request.status = @"1";
            [request  startRequest];
        }];
        
        [self.canleBtn bk_whenTapped:^{
            
            EDSStudentAppointmentRequest *request = [EDSStudentAppointmentRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
                
            } failureBlock:^(NSError *error) {
                
            }];
            request.schoolId = model.schoolId;
            request.appointmentId = model.appointmentId;
            request.studentId = [EDSSave account].userID;
            request.status = @"10";
            [request startRequest];
        }];
    }
}



- (UIButton *)determineBtn
{
    if (!_determineBtn) {
        
        _determineBtn = [[UIButton alloc] init];
        [_determineBtn setTitle:@"确认预约" forState:UIControlStateNormal];
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
            make.width.mas_equalTo(165);
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
            make.width.mas_equalTo(165);
            make.bottom.mas_equalTo(-15);
        }];
    }
    return _canleBtn;
}


@end
