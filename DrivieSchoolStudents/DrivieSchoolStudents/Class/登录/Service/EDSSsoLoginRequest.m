//
//  EDSSsoLoginRequest.m
//  DrivieSchoolStudents
//
//  Created by kkmm on 2018/12/26.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSSsoLoginRequest.h"
#import "XGPush.h"
#import "EDSFourDataBase.h"
#import "EDSDataBase.h"
@implementation EDSSsoLoginRequest

- (NSString *)requestURLPath
{
	return @"/app/lexiang/login/appStudentThirdLogin";
}

- (HQMRequestMethod)requestMethod
{
	return HQMRequestMethodPOST;
}

- (NSDictionary *)requestArguments
{
	return @{
			 @"type":_type,
			 @"openId":_openId,
			 };
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{

    if([data[@"phone"] length] == 11){
        EDSAccount *account = [[EDSAccount alloc] initWithDict:data];
        account.firstSubjectID = @"";
        account.fourSubjectID = @"";
        account.firstSubjectRecitedPoliticeID = @"";
        account.fourSubjectRecitedPoliticeID = @"";
        [[EDSFourDataBase  sharedDataBase] clearFourSubjectAllWrongQuestions];
        [[EDSDataBase  sharedDataBase] clearFirstSubjectAllWrongQuestions];
        [EDSSave save:account];
        [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:[EDSSave account].phone type:XGPushTokenBindTypeAccount];
    }
	if (self.successBlock) {
		
		self.successBlock(resCode, data, nil);
	}
}
@end
