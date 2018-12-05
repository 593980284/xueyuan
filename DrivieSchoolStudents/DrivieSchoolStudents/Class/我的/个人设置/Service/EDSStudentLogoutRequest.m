//
//  EDSStudentLogoutRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/10/11.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSStudentLogoutRequest.h"

@implementation EDSStudentLogoutRequest

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (NSDictionary *)requestArguments
{
    return @{};
}

- (NSString *)requestURLPath
{
    return @"/app/lexiang/login/appStudentLogout";
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    if (self.successBlock) {
        
        self.successBlock(resCode, data, nil);
    }
}

@end
