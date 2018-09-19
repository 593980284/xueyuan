//
//  EDSStudentExamResultInfoModel.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/14.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentExamResultInfoModel.h"

@implementation EDSStudentExamResultInfoModel

- (NSString *)subType
{
    if ([_subType isEqual:@"1"]) {
        
        return @"科目一";
    }else if ([_subType isEqual:@"2"])
    {
        return @"科目二";
    }else if ([_subType isEqual:@"3"])
    {
        return @"科目三";
    }else if ([_subType isEqual:@"4"])
    {
        return @"文明驾驶";
    }
    return @"";
}

- (NSString *)examMarks
{
    return [NSString stringWithFormat:@"%@分",_examMarks];
}

- (NSString *)examResult
{
    if ([_examResult isEqual:@"1"]) {
    
        return @"合格";
    }else {
    
        return @"不合格";
    }
    return @"";
}

@end
