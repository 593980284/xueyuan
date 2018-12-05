//
//  EDSCourseRecordModel.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/13.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordModel.h"

@implementation EDSCourseRecordModel

- (NSString *)showSubjectAge
{
    return [NSString stringWithFormat:@"%@ %@年教龄",_teachType,self.teachAge];
}

- (NSString *)teachAge
{
    return _teachAge.length > 0 ? _teachAge : @"0";
}

- (NSString *)coachPhoto
{
    return [LINEURL stringByAppendingPathComponent:_coachPhoto];
}

- (NSString *)showSubjecthour
{
    return [NSString stringWithFormat:@"课程:%@  学时:%@小时",_subjectName,_hours];
}

- (NSString *)coachScore
{
    return [NSString stringWithFormat:@"%.1f",[_coachScore floatValue]];
}

- (NSString *)status
{
    return [NSString stringWithFormat:@"%@",_status];
}

- (BOOL)isComment
{
    return _coachScore.length > 0 ? YES : NO;
}

- (NSAttributedString *)showStatus
{
    NSString *string = [NSString stringWithFormat:@"%@",_status];
    NSInteger status = [_status integerValue];
    if ((status == 2 || status == 6) && _coachScore > 0) {
        status = 8;
    }
    NSString * statusText = @[@"已预约",@"学员签到",@"已完成",@"缺勤",@"未签到",@"等待确认",@"已完成",@"缺勤", @"已完成 - 未评价"][status];
    UIColor * colot = [UIColor greenColor];
    if (status == 2 || status == 6 || status == 8) {
        colot = [UIColor blueColor];
    }else if (status == 3 || status == 7){
        colot = [UIColor orangeColor];
    }
    
    return [[NSAttributedString alloc]initWithString:statusText attributes:@{
                                                                             NSFontAttributeName: [UIFont systemFontOfSize:13],
                                                                             NSForegroundColorAttributeName: colot
                                                                             }];
}


@end
