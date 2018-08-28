//
//  EDSAppTouristRegistRequest.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSAppTouristRegistRequest.h"

@implementation EDSAppTouristRegistRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/login/appTouristRegist";
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (NSDictionary *)requestArguments
{
    return @{
             @"phone":_phone,
             @"password":_password,
             };
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    if (self.successBlock) {
        
        self.successBlock(resCode, data, nil);
    }
}
@end
