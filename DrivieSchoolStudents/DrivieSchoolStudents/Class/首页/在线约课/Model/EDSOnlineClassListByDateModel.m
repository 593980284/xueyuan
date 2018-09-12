//
//  EDSOnlineClassListByDateModel.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineClassListByDateModel.h"

@implementation EDSOnlineClassListByDateModel

- (NSString *)showListImg
{
    return [LINEURL stringByAppendingPathComponent:_coachPhoto];
}

- (NSString *)showSubjectTime
{
    return [NSString stringWithFormat:@"%@ %@",_subjectName,_shortPeriodTime];
}

- (NSString *)showSubjectAge
{
    return [NSString stringWithFormat:@"%@教龄 %@",_teachAge,_subjectName];
}

- (NSInteger)showCoachStar
{
    return ceil([_coachStar integerValue]/2);
}

- (NSString *)showNoAppointmentNum
{
    return [NSString stringWithFormat:@"剩余%@",_noAppointmentNum];
}
@end
