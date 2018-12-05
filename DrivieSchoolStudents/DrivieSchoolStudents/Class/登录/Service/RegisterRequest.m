//
//  RegisterRequest.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/5.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "RegisterRequest.h"

@implementation RegisterRequest

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (NSString *)requestURLPath
{
    if (_step == 0) {
        return @"/app/lexiang/login/appCheckRegisterCode";
    }
    return @"/app/lexiang/login/appSaveStudentPassword";
}

- (NSDictionary *)requestArguments
{
    if (_step == 0) {
        return @{
                 @"phone":_phone,
                 @"msgCode": _msgCode
                 };
    }
    return  @{
              @"phone":_phone,
              @"password": _password
              };
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    if (self.successBlock) {
        
        self.successBlock(resCode, data, nil);
    }
}
@end
