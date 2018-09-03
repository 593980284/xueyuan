//
//  EDSStudentPreSignUpRequest.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentPreSignUpRequest.h"

@implementation EDSStudentPreSignUpRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/presignup/studentPreSignUp";
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (NSDictionary *)requestArguments
{
    return @{
             @"schoolId":_schoolId,
             @"studentName":_studentName,
             @"certNo":_certNo,
             @"mobile":_mobile,
             @"applyDriveCar":_applyDriveCar,
             @"appointmentTime":_appointmentTime,
             @"signupSource":_signupSource,
             };
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    if (self.successBlock) {
        
        self.successBlock(resCode, data, nil);
        
    }
}
@end
