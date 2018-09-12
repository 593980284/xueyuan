//
//  EDSStudentAppointmentRequest.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface EDSStudentAppointmentRequest : HQMBaseRequest

@property (nonatomic , copy) NSString *schoolId;//驾校id
@property (nonatomic , copy) NSString *studentId;//学员id
@property (nonatomic , copy) NSString *appointmentId;//约课id
@property (nonatomic , copy) NSString *status;//状态

@end
