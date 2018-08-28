//
//  EDSAppTouristRegistRequest.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//游客保存账号密码接口

#import "HQMBaseRequest.h"

@interface EDSAppTouristRegistRequest : HQMBaseRequest

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *password;
@end
