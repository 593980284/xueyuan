//
//  BusListRequest.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2019/3/2.
//  Copyright © 2019年 班文政. All rights reserved.
//


#import "BusListRequest.h"

@implementation BusListRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/homePage/getShuttleBusList";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"type":self.type,
             @"phone":  [EDSSave account].phone
             };
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
    
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    if (self.successBlock) {
        self.successBlock(resCode, nil, data);
    }
}
@end

