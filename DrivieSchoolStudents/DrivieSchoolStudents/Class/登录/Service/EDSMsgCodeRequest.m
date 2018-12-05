//
//  EDSMsgCodeRequest.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSMsgCodeRequest.h"

@implementation EDSMsgCodeRequest

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (NSString *)requestURLPath
{
    if ([_type isEqualToString:@"register"]) {
        return @"/app/lexiang/login/appRegisterMsgCode";
    }
    return @"/app/lexiang/login/appMsgCode";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"phone":_phone,
             };
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    if (self.successBlock) {
        
        self.successBlock(resCode, data, nil);
    }
}
@end
