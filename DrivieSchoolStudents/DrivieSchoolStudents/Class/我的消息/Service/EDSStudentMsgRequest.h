//
//  EDSStudentMsgRequest.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/10.
//  Copyright © 2018年 班文政. All rights reserved.
//查询此学员的消息列表

#import "HQMBaseRequest.h"

@interface EDSStudentMsgRequest : HQMBaseRequest

@property (nonatomic , copy) NSString *phone;//学员手机号
@property (nonatomic , copy) NSString *type;//消息类型  必填，1：系统消息，2：驾校消息

@end
