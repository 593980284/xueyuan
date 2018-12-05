//
//  EDSStudentExamResultInfoRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/14.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentExamResultInfoRequest.h"
#import "EDSStudentExamResultInfoModel.h"

@implementation EDSStudentExamResultInfoRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/learningQuery/findStudentExamResultInfo";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"phone":_phone,
             };
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
     NSArray <EDSStudentExamResultInfoModel *> *model = [EDSStudentExamResultInfoModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"list"]];
    
    if (self.successBlock) {
        
        self.successBlock(resCode, data, model);
    }
}


@end
