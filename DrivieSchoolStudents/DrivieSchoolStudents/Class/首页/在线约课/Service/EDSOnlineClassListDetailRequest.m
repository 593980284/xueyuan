//
//  EDSOnlineClassListDetailRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/19.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineClassListDetailRequest.h"

#import "EDSOnlineClassListByDateModel.h"

@implementation EDSOnlineClassListDetailRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/course/findOnlineClassListDetail";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"appointmentId":_appointmentId,
             @"studentId":_studentId,
             };
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    EDSOnlineClassListByDateModel *model = [EDSOnlineClassListByDateModel mj_objectWithKeyValues:data];
    if (self.successBlock) {
        
        self.successBlock(resCode, data, model);
    }
}

@end
