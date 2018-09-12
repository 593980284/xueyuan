//
//  EDSStudentChangePassWordRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentChangePassWordRequest.h"

@implementation EDSStudentChangePassWordRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/studentSetting/appStudentChangePassWord";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"phone":[EDSSave account].phone,
             @"oldPassword":_oldPassword,
             @"newPassword":_password,
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
