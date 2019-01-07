//
//  LessonDetailsRequest.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "LessonDetailsRequest.h"
#import "EDSOnlineClassListByDateModel.h"

@implementation LessonDetailsRequest
- (NSString *)requestURLPath
{
    return @"/app/lexiang/course/findOnlineClassListDetail";
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
        self.successBlock(resCode, data, [EDSOnlineClassListByDateModel mj_objectWithKeyValues:data]);
    }
}
@end
