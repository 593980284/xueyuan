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

- (NSString *)showStatus
{
    NSString *string = [NSString stringWithFormat:@"%@",_status];
    if ([string isEqualToString:@"2"] || [string isEqualToString:@"6"]) {
        
        if (_coachScore.length == 0) {
            
            return @"待评价";
        }
    }else if ([string isEqualToString:@"3"] || [string isEqualToString:@"7"])
    {
        return @"缺勤";
    }else if ([string isEqualToString:@"0"] || [string isEqualToString:@"1"] || [string isEqualToString:@"4"])
    {
        return @"未确认";
    }else if ([string isEqualToString:@"5"]){
        
        return @"教练补签";
    }
    else{
        
        return @"未确认";
    }
    return @"";
}


@end
