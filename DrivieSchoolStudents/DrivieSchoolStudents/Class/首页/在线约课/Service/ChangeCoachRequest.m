//
//  ChangeCoachRequest.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "ChangeCoachRequest.h"

@implementation ChangeCoachRequest
- (NSString *)requestURLPath
{
    return @"/app/lexiang/coachChangeApply/appChangeCoachApply";
}

- (NSDictionary *)requestArguments
{
//    return @{
//             @"phone":_phone,
//             @"applyReason": _applyReason,
//             @"coachId": _coachId,
//             @"classId": _classId,
//             @"subjectId": _subjectId
//             };
    return [self mj_keyValues];
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
