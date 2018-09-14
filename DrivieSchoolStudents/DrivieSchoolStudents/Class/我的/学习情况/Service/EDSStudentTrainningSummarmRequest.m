//
//  EDSStudentTrainningSummarmRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/14.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentTrainningSummarmRequest.h"
#import "EDSStudentTrainningSummaryModel.h"

@implementation EDSStudentTrainningSummarmRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/learningQuery/getStudentTrainningSummary";
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
    EDSStudentTrainningSummaryModel *model = [EDSStudentTrainningSummaryModel mj_objectWithKeyValues:data];
    if (self.successBlock) {
        
        self.successBlock(resCode, data, model);
    }
}

@end
