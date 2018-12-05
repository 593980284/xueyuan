//
//  EDSMsgCodeLoginRequest.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSMsgCodeLoginRequest.h"
#import "XGPush.h"

@implementation EDSMsgCodeLoginRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/login/appStudentMsgCodeLogin";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"phone":_phone,
             @"msgCode":_msgCode,
             };
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    if (resCode == 1) {
        EDSAccount *account = [[EDSAccount alloc] initWithDict:data];
        [EDSSave save:account];
        [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:account.phone type:XGPushTokenBindTypeAccount];
    }
    if (self.successBlock) {
        self.successBlock(resCode, data, nil);
    }
}

- (HQMRequestMethod)requestMethod{
    return HQMRequestMethodPOST;
}
@end
