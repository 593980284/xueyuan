//
//  EDSOnlineClassDateListModel.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineClassDateListModel.h"

@implementation EDSOnlineClassDateListModel

- (NSString *)showWeak
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // NSString * -> NSDate *
    NSDate *dt = [fmt dateFromString:_date];
    
    return [EDSToolClass weekdayStringFromDate:dt];
}

- (NSString *)showDay
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // NSString * -> NSDate *
    NSDate *dt = [fmt dateFromString:_date];
    // 利用NSCalendar处理日期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit  fromDate:dt];
    
    return [NSString stringWithFormat:@"%ld",(long)cmps.day];
}

- (BOOL)isSubject
{
    NSString *string = [NSString stringWithFormat:@"%@", _has];
    return [string isEqual:@"0"] ? YES : NO;
}

@end
