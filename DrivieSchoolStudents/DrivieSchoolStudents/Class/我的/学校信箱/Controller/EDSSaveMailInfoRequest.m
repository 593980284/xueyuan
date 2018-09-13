//
//  EDSSaveMailInfoRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/13.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSaveMailInfoRequest.h"

@implementation EDSSaveMailInfoRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/schoolMailbox/saveMailInfo";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"phone":_phone,
             @"type":_type,
             @"pubContent":_pubContent,
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
