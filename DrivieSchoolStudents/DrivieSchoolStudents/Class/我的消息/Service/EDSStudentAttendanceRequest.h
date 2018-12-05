//
//  EDSStudentAttendanceRequest.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/13.
//  Copyright © 2018年 班文政. All rights reserved.
//学员对教练补签进行回应

#import "HQMBaseRequest.h"

@interface EDSStudentAttendanceRequest : HQMBaseRequest

@property (nonatomic , copy) NSString *courseRecordId;//约课记录id
@property (nonatomic , copy) NSString *status;//课程考勤状态

@end
