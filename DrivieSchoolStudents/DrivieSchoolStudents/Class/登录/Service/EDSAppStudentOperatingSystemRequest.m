//
//  EDSAppStudentOperatingSystemRequest.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/6.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSAppStudentOperatingSystemRequest.h"

@implementation EDSAppStudentOperatingSystemRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/login/appStudentOperatingSystem";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"phone":_phone,
             @"operatingSystem":_operatingSystem,
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
