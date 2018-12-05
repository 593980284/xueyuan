//
//  cyhCalenbardate.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cyhCalenbardate : NSObject
//计算一个月的天数
- (NSInteger)daysInthisMonth:(NSDate *)date;
//计算年月日，星期（只呈现1，2，3，4。。。。）
- (NSDateComponents *)year_month_todayInthisMonth:(NSDate *)date;
//一个月的第一天是星期几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
//星期几
- (NSString *)weekday:(NSDate *)date;
//一个月有多少星期
- (NSUInteger)numberOfWeeksInCurrentMonth:(NSDate *)date;
//上个月日历
- (NSDate *)lastMonthDate:(NSDate *)date;
//下个月的日历
- (NSDate *)nextMonthDate:(NSDate *)date;

//下一年的月历
- (NSDate *)nextyeasDate:(NSDate *)date;
//上一年的月历
- (NSDate *)lastYeasDate:(NSDate *)date;


@end
