//
//  EDSOnlineAboutClassDetailAppointmentDownView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineAboutClassDetailAppointmentDownView.h"

@interface EDSOnlineAboutClassDetailAppointmentDownView ()

@end

@implementation EDSOnlineAboutClassDetailAppointmentDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

- (void)setup{
    
    //没有预约的情况
    UIButton *determineBtn = [[UIButton alloc] init];
    [determineBtn setTitle:@"确认预约" forState:UIControlStateNormal];
    [determineBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    determineBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    determineBtn.backgroundColor = ThemeColor;
    determineBtn.layer.cornerRadius = 5;
    determineBtn.layer.masksToBounds = YES;
    [self addSubview:determineBtn];
    [determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(-18);
    }];
    
    //预约的情况
    UIButton *signinBtn = [[UIButton alloc] init];
    [signinBtn setTitle:@"课程签到" forState:UIControlStateNormal];
    [signinBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    signinBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    signinBtn.backgroundColor = ThirdColor;
    signinBtn.layer.cornerRadius = 5;
    signinBtn.layer.masksToBounds = YES;
    [self addSubview:signinBtn];
    [signinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(165);
        make.bottom.mas_equalTo(-15);
    }];
    
    UIButton *canleBtn = [[UIButton alloc] init];
    [canleBtn setTitle:@"取消预约" forState:UIControlStateNormal];
    [canleBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    canleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    canleBtn.backgroundColor = ThemeColor;
    canleBtn.layer.cornerRadius = 5;
    canleBtn.layer.masksToBounds = YES;
    [self addSubview:canleBtn];
    [canleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(165);
        make.bottom.mas_equalTo(-15);
    }];
    
    determineBtn.hidden = YES;
    signinBtn.hidden = NO;
    canleBtn.hidden = NO;
}

@end
