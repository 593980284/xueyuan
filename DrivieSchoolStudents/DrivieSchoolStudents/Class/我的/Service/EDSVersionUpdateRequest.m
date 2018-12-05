//
//  EDSVersionUpdateRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/20.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSVersionUpdateRequest.h"

@implementation EDSVersionUpdateRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/homePage/versionUpdate";
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (NSDictionary *)requestArguments
{
    return @{
             @"title":_title
             };
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    if (self.successBlock) {
        
        self.successBlock(resCode, data, nil);
    }
}

@end
