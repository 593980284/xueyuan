//
//  EDSCourseRecordDetailDownView.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/14.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordDetailDownView.h"

@interface EDSCourseRecordDetailDownView ()

@property (nonatomic , strong) UIButton *evaluationBtn;//评价
@property (nonatomic , strong) UIButton *uncertainBtn;//未确定
@property (nonatomic , strong) UIButton *absenteeismBtn;//缺勤
@property (nonatomic , strong) UIButton *confirmClassBtn;//确认到课
@property (nonatomic , strong) UIButton *notComeBtn;//我没有来

@end

@implementation EDSCourseRecordDetailDownView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup{
    
    [self.confirmClassBtn bk_whenTapped:^{
        DLog(@"确认到课");
    }];
    
    [self.notComeBtn bk_whenTapped:^{
        DLog(@"确认到课");
    }];
}


- (UIButton *)evaluationBtn
{
    if (!_evaluationBtn) {
        
        _evaluationBtn = [[UIButton alloc] init];
        [_evaluationBtn setTitle:@"评价" forState:UIControlStateNormal];
        [_evaluationBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _evaluationBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _evaluationBtn.backgroundColor = ThemeColor;
        _evaluationBtn.layer.cornerRadius = 5;
        _evaluationBtn.layer.masksToBounds = YES;
        [self addSubview:_evaluationBtn];
        [_evaluationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(45);
            make.bottom.mas_equalTo(-18);
        }];
    }
    return _evaluationBtn;
}

- (UIButton *)uncertainBtn
{
    if (!_uncertainBtn) {
        
        _uncertainBtn = [[UIButton alloc] init];
        [_uncertainBtn setTitle:@"未确定" forState:UIControlStateNormal];
        [_uncertainBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _uncertainBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _uncertainBtn.backgroundColor = ThemeColor;
        _uncertainBtn.layer.cornerRadius = 5;
        _uncertainBtn.layer.masksToBounds = YES;
        [self addSubview:_uncertainBtn];
        [_uncertainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(45);
            make.bottom.mas_equalTo(-18);
        }];
    }
    return _uncertainBtn;
}

- (UIButton *)absenteeismBtn
{
    if (!_absenteeismBtn) {
        
        _absenteeismBtn = [[UIButton alloc] init];
        [_absenteeismBtn setTitle:@"缺勤" forState:UIControlStateNormal];
        [_absenteeismBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _absenteeismBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _absenteeismBtn.backgroundColor = SecondColor;
        _absenteeismBtn.layer.cornerRadius = 5;
        _absenteeismBtn.layer.masksToBounds = YES;
        [self addSubview:_absenteeismBtn];
        [_absenteeismBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(45);
            make.bottom.mas_equalTo(-18);
        }];
    }
    return _absenteeismBtn;
}

- (UIButton *)confirmClassBtn
{
    if (!_confirmClassBtn) {
        
        _confirmClassBtn = [[UIButton alloc] init];
        [_confirmClassBtn setTitle:@"确认到课" forState:UIControlStateNormal];
        [_confirmClassBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _confirmClassBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _confirmClassBtn.backgroundColor = SecondColor;
        _confirmClassBtn.layer.cornerRadius = 5;
        _confirmClassBtn.layer.masksToBounds = YES;
        [self addSubview:_confirmClassBtn];
        [_confirmClassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(self.notComeBtn.mas_left).mas_equalTo(-15);
            make.height.mas_equalTo(45);
            make.bottom.mas_equalTo(-18);
        }];
    }
    return _confirmClassBtn;
}

- (UIButton *)notComeBtn
{
    if (!_notComeBtn) {
        
        _notComeBtn = [[UIButton alloc] init];
        [_notComeBtn setTitle:@"我没有来" forState:UIControlStateNormal];
        [_notComeBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        _notComeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _notComeBtn.backgroundColor = SecondColor;
        _notComeBtn.layer.cornerRadius = 5;
        _notComeBtn.layer.masksToBounds = YES;
        [self addSubview:_notComeBtn];
        [_notComeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(45);
            make.width.mas_equalTo(self.confirmClassBtn.mas_width);
            make.bottom.mas_equalTo(-18);
        }];
    }
    return _notComeBtn;
}

@end
