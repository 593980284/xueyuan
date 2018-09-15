//
//  EDSCommentSubmitReqest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/15.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCommentSubmitReqest.h"

@implementation EDSCommentSubmitReqest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/course/studentEvaluationCoach";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"courseRecordId":_courseRecordId,
             @"coachAbilityScore":_coachAbilityScore,
             @"coachAttitudeScore":_coachAttitudeScore,
             @"coachHygieneScore":_coachHygieneScore,
             @"coachLabel":_coachLabel,
             @"coachEvaluationContent":_coachEvaluationContent,
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
