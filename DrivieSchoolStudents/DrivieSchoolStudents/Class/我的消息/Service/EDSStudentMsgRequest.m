//
//  EDSStudentMsgRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/10.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentMsgRequest.h"

@implementation EDSStudentMsgRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/message/findStudentMsg";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"phone":_phone,
             @"type":_type
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
