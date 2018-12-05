//
//  EDSMsgCodeRequest.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//获得短信验证码接口

#import "HQMBaseRequest.h"
@interface EDSMsgCodeRequest : HQMBaseRequest
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *type;
@end
