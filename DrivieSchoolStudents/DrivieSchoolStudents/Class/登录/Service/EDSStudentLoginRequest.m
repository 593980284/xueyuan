//
//  EDSStudentLoginRequest.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentLoginRequest.h"
#import "XGPush.h"
#import "EDSFourDataBase.h"
#import "EDSDataBase.h"

@implementation EDSStudentLoginRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/login/appStudentLogin";
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
    if ([[EDSSave account].phone isEqualToString:_phone]) {
        
        EDSAccount *account = [[EDSAccount alloc] initWithDict:data];
        [EDSSave save:account];
    }else{
        
        EDSAccount *account = [[EDSAccount alloc] initWithDict:data];
        account.firstSubjectID = @"";
        account.fourSubjectID = @"";
        account.firstSubjectRecitedPoliticeID = @"";
        account.fourSubjectRecitedPoliticeID = @"";
        [[EDSFourDataBase  sharedDataBase] clearFourSubjectAllWrongQuestions];
        [[EDSDataBase  sharedDataBase] clearFirstSubjectAllWrongQuestions];
        [EDSSave save:account];
    }
    
    [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:[EDSSave account].phone type:XGPushTokenBindTypeAccount];
    if (self.successBlock) {
        
        self.successBlock(resCode, data, nil);
    }
}
@end
