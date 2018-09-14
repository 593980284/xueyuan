//
//  EDSStudentEvaluationCoachRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/14.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentEvaluationCoachRequest.h"

@implementation EDSStudentEvaluationCoachRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/course/findStudentEvaluationCoach";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"courseRecordId":_courseRecordId,
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
