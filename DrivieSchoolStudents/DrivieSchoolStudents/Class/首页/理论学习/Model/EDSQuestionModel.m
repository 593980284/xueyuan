//
//  EDSQuestionModel.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSQuestionModel.h"

@implementation EDSAnswerModel

@end

@implementation EDSQuestionModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"answerlists":[EDSAnswerModel class],
             };
}

@end
