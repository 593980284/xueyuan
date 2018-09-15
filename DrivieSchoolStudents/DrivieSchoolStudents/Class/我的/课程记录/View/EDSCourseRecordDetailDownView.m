//
//  EDSCourseRecordDetailDownView.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/14.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordDetailDownView.h"

#import "EDSCourseRecordModel.h"

#import "EDSStudentAttendanceRequest.h"

@interface EDSCourseRecordDetailDownView ()

@property (nonatomic , strong) UIButton *evaluationBtn;             //评价
@property (nonatomic , strong) UIButton *uncertainBtn;              //未确定
@property (nonatomic , strong) UIButton *absenteeismBtn;            //缺勤
@property (nonatomic , strong) UIButton *confirmClassBtn;           //确认到课
@property (nonatomic , strong) UIButton *notComeBtn;                //我没有来
@property (nonatomic , strong) UIButton *haveEvaluation;            //已评价

@end

@implementation EDSCourseRecordDetailDownView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)setCourseRecordModel:(EDSCourseRecordModel *)courseRecordModel
{
    _courseRecordModel = courseRecordModel;
    
    self.evaluationBtn.hidden = YES;
    self.uncertainBtn.hidden = YES;
    self.absenteeismBtn.hidden = YES;
    self.confirmClassBtn.hidden = YES;
    self.notComeBtn.hidden = YES;
    self.haveEvaluation.hidden = YES;
    
    if ([courseRecordModel.status isEqual:@"2"] || [courseRecordModel.status isEqual:@"6"]) {
     //已到 有分数显示分数，没分数显示待评价
        if (courseRecordModel.coachScore.length > 0) {
            
            self.haveEvaluation.hidden = NO;
            
        }else{
            
            self.evaluationBtn.hidden = NO;
        }
    }else if ([courseRecordModel.status isEqual:@"3"] || [courseRecordModel.status isEqual:@"7"]){
        
        self.absenteeismBtn.hidden = NO;
        
        //显示缺勤
    }else if ([courseRecordModel.status isEqual:@"0"] || [courseRecordModel.status isEqual:@"1"] || [courseRecordModel.status isEqual:@"4"]){
        
        self.uncertainBtn.hidden = NO;
        //显示未确认
    }else{
        self.confirmClassBtn.hidden = NO;
        self.notComeBtn.hidden = NO;
        //显示教练补签，在详情页面显示确认到课、我没有来按钮
    }
    
    [self.haveEvaluation bk_whenTapped:^{
        DLog(@"已评价");
        if (self.courseRecordDetailDownViewDidButtonBackTitle) {
            
            self.courseRecordDetailDownViewDidButtonBackTitle(@"查看评价");
        }
    }];
    
    [self.evaluationBtn bk_whenTapped:^{
        DLog(@"评价");
        if (self.courseRecordDetailDownViewDidButtonBackTitle) {
            
            self.courseRecordDetailDownViewDidButtonBackTitle(@"评价");
        }
    }];
    
    [self.absenteeismBtn bk_whenTapped:^{
        DLog(@"缺勤");
    }];
    
    [self.uncertainBtn bk_whenTapped:^{
        DLog(@"未确认");
    }];
    
    [self.confirmClassBtn bk_whenTapped:^{
        DLog(@"确认到课");
        [self studentAttendanceWithStatus:@"6"];
    }];
    
    [self.notComeBtn bk_whenTapped:^{
        DLog(@"我没有来");
        [self studentAttendanceWithStatus:@"7"];
    }];
}

- (void)studentAttendanceWithStatus:(NSString *)status
{
    EDSStudentAttendanceRequest *request = [EDSStudentAttendanceRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            
            self.confirmClassBtn.hidden = YES;
            self.notComeBtn.hidden = YES;
            
            if ([status isEqual:@"6"]) {//确认去上课
                
                self.evaluationBtn.hidden = NO;
            }else{
                
                self.absenteeismBtn.hidden = NO;
            }
        }
    } failureBlock:^(NSError *error) {
    
    }];
    request.status = status;
    request.courseRecordId = self.courseRecordModel.courseRecordId;
    request.showHUD = YES;
    [request startRequest];
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
        _uncertainBtn.backgroundColor = SecondColor;
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

- (UIButton *)haveEvaluation
{
    if (!_haveEvaluation) {
        
        _haveEvaluation = [[UIButton alloc] init];
        [_haveEvaluation setTitle:@"查看评价" forState:UIControlStateNormal];
        [_haveEvaluation setTitleColor:WhiteColor forState:UIControlStateNormal];
        _haveEvaluation.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _haveEvaluation.backgroundColor = ThemeColor;
        _haveEvaluation.layer.cornerRadius = 5;
        _haveEvaluation.layer.masksToBounds = YES;
        [self addSubview:_haveEvaluation];
        [_haveEvaluation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(45);
            make.bottom.mas_equalTo(-18);
        }];
    }
    return _haveEvaluation;
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
        _confirmClassBtn.backgroundColor = ThemeColor;
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
        _notComeBtn.backgroundColor = ThemeColor;
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
