//
//  EDSStudentMsgDetailRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/10.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentMsgDetailRequest.h"

@implementation EDSStudentMsgDetailRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/message/findSingleStudentMsg";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"msgId":_msgId
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
