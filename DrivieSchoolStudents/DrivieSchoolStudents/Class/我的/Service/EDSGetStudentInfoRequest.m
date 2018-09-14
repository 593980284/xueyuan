//
//  EDSGetStudentInfoRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/14.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSGetStudentInfoRequest.h"

@implementation EDSGetStudentInfoRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/studentSetting/getStudentInfo";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"phone":_phone,
             };
}

- (HQMRequestMethod)requestMethod{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    EDSAccount *account = [EDSSave account];
    account.phone = [NSString stringWithFormat:@"%@",data[@"phone"]];
    account.schoolId = [NSString stringWithFormat:@"%@",data[@"schoolId"]];
    account.userID = [NSString stringWithFormat:@"%@",data[@"id"]];
    account.learnProgress = [NSString stringWithFormat:@"%@",data[@"learnProgress"]];
    account.schoolName = [NSString stringWithFormat:@"%@",data[@"schoolName"]];
    account.photo = [NSString stringWithFormat:@"%@",[LINEURL stringByAppendingPathComponent:data[@"photo"]]];;
    account.state = [NSString stringWithFormat:@"%@",data[@"state"]];
    account.applyDriveCar = [NSString stringWithFormat:@"%@",data[@"applyDriveCar"]];
    [EDSSave save:account];
    if (self.successBlock) {
        
        self.successBlock(resCode, data, nil);
    }
}
@end
