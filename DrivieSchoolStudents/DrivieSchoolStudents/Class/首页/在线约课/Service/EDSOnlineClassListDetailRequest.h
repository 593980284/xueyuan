//
//  EDSOnlineClassListDetailRequest.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/19.
//  Copyright © 2018年 班文政. All rights reserved.
//查询在线预课列表详情接口

#import "HQMBaseRequest.h"

@interface EDSOnlineClassListDetailRequest : HQMBaseRequest

@property (nonatomic , copy) NSString *appointmentId;//课程ID
@property (nonatomic , copy) NSString *studentId;//学员ID

@end
