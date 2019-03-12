//
//  SubjectListRequest.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2019/3/6.
//  Copyright © 2019年 班文政. All rights reserved.
///app/lexiang/course/findOnlineClassListBySubject

#import "SubjectListRequest.h"
#import "EDSOnlineClassListByDateModel.h"

@implementation SubjectListRequest
- (NSString *)requestURLPath
{
    return @"/app/lexiang/course/findOnlineClassListBySubject";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"date":self.date,
             @"phone":[EDSSave account].phone,
                 @"subjectId":self.subjectId
             };
    
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    if (self.successBlock) {
        self.successBlock(resCode, data, [EDSOnlineClassListByDateModel mj_objectArrayWithKeyValuesArray:data[@"list"]]);
    }
}
@end
