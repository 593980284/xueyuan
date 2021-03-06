//
//  EDSStudentEvaluationCoachRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/14.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentEvaluationCoachRequest.h"
#import "EDSCommentDetailModel.h"

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
    EDSCommentDetailModel *model = [EDSCommentDetailModel mj_objectWithKeyValues:data];
    
    if (self.successBlock) {
        
        self.successBlock(resCode, data, model);
    }
}
@end
