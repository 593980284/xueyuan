//
//  EDSStudentCheckOldPhoneRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentCheckOldPhoneRequest.h"

@implementation EDSStudentCheckOldPhoneRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/studentSetting/appStudentCheckOldPhone";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"phone":_phone,
             @"id":[EDSSave account].userID,
             @"msgCode":_msgCode,
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
