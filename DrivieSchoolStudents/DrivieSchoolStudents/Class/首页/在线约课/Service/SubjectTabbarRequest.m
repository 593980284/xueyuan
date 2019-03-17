//
//  SubjectTabbarRequest.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2019/3/5.
//  Copyright © 2019年 班文政. All rights reserved.
///app/lexiang/course/findSubjectTable

#import "SubjectTabbarRequest.h"
@implementation SubjectTabbarModel
@end
@implementation SubjectTabbarRequest
- (NSString *)requestURLPath
{
    return @"/app/lexiang/course/findSubjectTable";
}

- (NSDictionary *)requestArguments
{
        return @{
                 @"studentId":[EDSSave account].studentId2?[EDSSave account].studentId2: @""
                 };
   
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    if (self.successBlock) {
        self.successBlock(resCode, data, [SubjectTabbarModel mj_objectArrayWithKeyValuesArray:data]);
    }
}
@end
