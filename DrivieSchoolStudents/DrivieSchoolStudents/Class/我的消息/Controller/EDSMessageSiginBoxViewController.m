//
//  EDSMessageSiginBoxViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/13.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSMessageSiginBoxViewController.h"

#import "EDSStudentAttendanceRequest.h"
#import "EDSStudentMsgDetailRequest.h"
#import "EDSOnlineClassListDetailRequest.h"

#import "EDSStudentMsgModel.h"
#import "EDSOnlineClassListByDateModel.h"



@interface EDSMessageSiginBoxViewController ()
{
    NSString *_appointmentId;
    NSString *_studentId;
}
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@property (nonatomic , copy) NSString *courseRecordId;
@property (nonatomic , copy) NSString *status;//课程对应的状态，5：学员未签到教练补签，6：学员确认补签， 7：学员否认补签
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (nonatomic , strong) EDSOnlineClassListByDateModel *model;

@end

@implementation EDSMessageSiginBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    EDSStudentMsgDetailRequest *request = [EDSStudentMsgDetailRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        if (errCode == 1) {
            
            self.courseRecordId = responseDict[@"courseRecordId"];
            self.contentLbl.text = responseDict[@"content"];
            self->_appointmentId = responseDict[@"appointmentId"];
            self->_studentId = responseDict[@"studentId"];
            self.status = [NSString stringWithFormat:@"%@",responseDict[@"status"]];
            
            [self onlineClassListDetailRequest];
            
            [self setup];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    request.msgId = self.msgModel.msgId;
    
    [request startRequest];
}


- (void)setup{
    
    if ([self.status isEqualToString:@"6"]) {
        //学员确认补签
        
        [self.button1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.bottom.mas_equalTo(-15);
            make.height.mas_equalTo(44);
        }];
        self.button2.hidden = YES;
        [self.button1 setBackgroundColor:ThirdColor];
        self.button1.userInteractionEnabled = NO;
    }else if([self.status isEqualToString:@"7"]){
        //学员否认补签
        
        [self.button2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.bottom.mas_equalTo(-15);
            make.height.mas_equalTo(44);
        }];
        self.button1.hidden = YES;
        [self.button2 setBackgroundColor:ThirdColor];
        self.button2.userInteractionEnabled = NO;
    }else{
        
    }
}

- (void)onlineClassListDetailRequest
{
    @weakify(self);
    EDSOnlineClassListDetailRequest *request = [EDSOnlineClassListDetailRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        
        self.model = model;
        
    } failureBlock:^(NSError *error) {
        
    }];
    request.appointmentId = _appointmentId;
    request.studentId = _studentId;
    [request startRequest];
}


- (IBAction)confirmClick:(id)sender {
    
    EDSStudentAttendanceRequest *request = [EDSStudentAttendanceRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            
            if (self.messageSiginBoxViewControllerDidClick) {
                
                self.messageSiginBoxViewControllerDidClick(self.model);
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failureBlock:^(NSError *error) {
    
    }];
    request.courseRecordId = self.courseRecordId;
    request.status = @"6";
    request.showHUD = YES;
    [request  startRequest];
}


- (IBAction)noGoClick:(id)sender {
    
    @weakify(self);
    EDSStudentAttendanceRequest *request = [EDSStudentAttendanceRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        if (errCode == 1) {
            
            if (self.messageSiginBoxViewControllerDidClick) {
                
                self.messageSiginBoxViewControllerDidClick(self.model);
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failureBlock:^(NSError *error) {
        
    }];
    request.courseRecordId = self.courseRecordId;
    request.status = @"7";
    request.showHUD = YES;
    [request  startRequest];
    
}

@end
