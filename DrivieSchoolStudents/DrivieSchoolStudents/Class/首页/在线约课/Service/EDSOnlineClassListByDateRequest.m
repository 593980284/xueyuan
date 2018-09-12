//
//  EDSOnlineClassListByDateRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineClassListByDateRequest.h"

@implementation EDSOnlineClassListByDateRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/course/findOnlineClassListByDate";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"phone":_phone,
             @"date":_date,
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
