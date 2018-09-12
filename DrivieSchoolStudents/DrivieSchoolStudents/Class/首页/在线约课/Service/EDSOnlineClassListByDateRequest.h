//
//  EDSOnlineClassListByDateRequest.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//查询在线预课列表接口

#import "HQMBaseRequest.h"

@interface EDSOnlineClassListByDateRequest : HQMBaseRequest

@property (nonatomic , copy) NSString *phone;//学员手机号
@property (nonatomic , copy) NSString *date;//日期

@end
