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

@property (nonatomic , copy) NSString *courseRecordId;
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
            
            [self onlineClassListDetailRequest];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    request.msgId = self.msgModel.msgId;
    
    [request startRequest];
}

- (void)onlineClassListDetailRequest
{
    @weakify(self);
    EDSOnlineClassListDetailRequest *request = [EDSOnlineClassListDetailRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        
        self.model = model;
        
    } failureBlock:^(NSError *error) {
        
    }];
    request.showHUD = YES;
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
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }
    } failureBlock:^(NSError *error) {
    
    }];
    request.courseRecordId = self.courseRecordId;
    request.status = @"6";
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
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }
    } failureBlock:^(NSError *error) {
        
    }];
    request.courseRecordId = self.courseRecordId;
    request.status = @"7";
    [request  startRequest];
    
}

@end
