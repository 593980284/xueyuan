//
//  EDSStudentCheckOldPhoneRequest.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//学员更换登录手机号接口(第一步)

#import "HQMBaseRequest.h"

@interface EDSStudentCheckOldPhoneRequest : HQMBaseRequest

@property (nonatomic, copy) NSString *phone;//学员旧手机号
@property (nonatomic, copy) NSString *msgCode;//手机短信验证码 

@end
