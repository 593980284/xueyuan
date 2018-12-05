//
//  EDSCommentDetailModel.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/15.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCommentDetailModel.h"

@implementation EDSBtnList

@end

@implementation EDSCommentDetailModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"list":[EDSBtnList class],
             };
}

- (NSString *)coachAbilityScore
{
    return [NSString stringWithFormat:@"%@",_coachAbilityScore];
}

- (NSString *)coachHygieneScore
{
    return [NSString stringWithFormat:@"%@",_coachHygieneScore];
}

- (NSString *)coachEvaluationContent
{
    return [NSString stringWithFormat:@"%@",_coachEvaluationContent];
}
@end
