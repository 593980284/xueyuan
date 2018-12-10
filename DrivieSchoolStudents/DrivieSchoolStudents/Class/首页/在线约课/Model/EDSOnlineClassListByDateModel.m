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
    return [NSString stringWithFormat:@"%@：%@",_subjectName,_shortPeriodTime];
}

- (NSString *)showSubjectAge
{
    return [NSString stringWithFormat:@"%@年教龄 %@",_teachAge,_subjectName];
}

- (NSDate *)startSiginDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    if (_periodTime.length > 0) {
        
        NSString *datestr = [_periodTime substringToIndex:16];
        date = [fmt dateFromString:datestr];
    }
    date = [date dateByAddingTimeInterval:-[_advanceSignInTime intValue]*60];
    DLog(@"%@",[fmt stringFromDate:date]);
    return date;
}

- (NSDate *)endSiginDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    if (_periodTime.length > 0) {
        
        NSString *datestr = [_periodTime substringToIndex:10];
        NSString *datestr2 = [_periodTime substringFromIndex:17];
        datestr = [NSString stringWithFormat:@"%@ %@",datestr, datestr2];
        date = [fmt dateFromString:datestr];
    }
    DLog(@"%@",[fmt stringFromDate:date]);
    return date;
}

- (NSDate *)cancleAppDate
{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    if (_periodTime.length > 0) {
        
        NSString *datestr = [_periodTime substringToIndex:16];
        date = [fmt dateFromString:datestr];
    }
    date = [date dateByAddingTimeInterval:-[_advanceCancelHours intValue]*60*60];
    DLog(@"%@",[fmt stringFromDate:date]);
    return date;
}

- (NSInteger)showCoachStar
{
    return ceil([_coachStar floatValue]/2);
}

- (NSString *)showNoAppointmentNum
{
    return [NSString stringWithFormat:@"剩余%@",_noAppointmentNum];
}
@end
