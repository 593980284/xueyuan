//
//  EDSStudentAppointmentRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentAppointmentRequest.h"

@implementation EDSStudentAppointmentRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/course/studentAppointment";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"schoolId":_schoolId,
             @"status":_status,
             @"studentId":_studentId,
             @"appointmentId":_appointmentId,
             };
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    if (self.successBlock) {
        
        self.successBlock(resCode, data, nil);
    }
}
@end
