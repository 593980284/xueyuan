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
@property (nonatomic, assign)BOOL requestTypeBindQQ_Wx;//i是否绑定微信、qqQQ
@property (nonatomic, assign)BOOL requestTypeNotBindQQ_Wx;//解绑微信、qqQQ

@property (nonatomic, copy) NSString *type;//登录方式，1：qq登录，2：微信登录
@property (nonatomic, copy) NSString *openId;
@property (nonatomic, copy) NSString *code;//绑定手机号时必填，绑定第三方账号时非必填
@property (nonatomic, copy) NSString *method;//绑定方式：1.绑定手机号，2.绑定第三方账号
@end
