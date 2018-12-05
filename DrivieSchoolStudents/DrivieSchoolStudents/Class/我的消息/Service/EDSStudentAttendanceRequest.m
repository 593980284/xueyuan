//
//  EDSStudentAttendanceRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/13.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentAttendanceRequest.h"

@implementation EDSStudentAttendanceRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/course/studentAttendance";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"courseRecordId":_courseRecordId,
             @"status":_status,
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
