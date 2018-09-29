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

- (NSString *)showStatus
{
    if ([_status isEqual:@"2"] || [_status isEqual:@"6"]) {
        
        if (_coachScore.length == 0) {
            
            return @"待评价";
        }
    }else if ([_status isEqual:@"3"] || [_status isEqual:@"7"])
    {
        return @"缺勤";
    }else if ([_status isEqual:@"0"] || [_status isEqual:@"1"] || [_status isEqual:@"4"])
    {
        return @"未确认";
    }else if ([_status isEqual:@"5"]){
        
        return @"教练补签";
    }
    else{
        
        return @"未确认";
    }
    return @"";
}


@end
