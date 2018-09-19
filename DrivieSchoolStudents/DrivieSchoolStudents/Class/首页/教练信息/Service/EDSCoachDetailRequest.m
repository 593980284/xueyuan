//
//  EDSCoachDetailRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/19.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCoachDetailRequest.h"
#import "EDSCoachListModel.h"

@implementation EDSCoachDetailRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/coach/findCoachDetail";
}

-  (NSDictionary *)requestArguments
{
    return @{
             @"coachId":_coachId,
             };
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    EDSCoachListModel *model = [EDSCoachListModel mj_objectWithKeyValues:data];
    if (self.successBlock) {
     
        self.successBlock(resCode, data, model);
    }
}
@end
