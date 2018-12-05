//
//  RegisterRequest.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/5.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface RegisterRequest : HQMBaseRequest
@property(nonatomic, copy)NSString * phone;
@property(nonatomic, copy)NSString * msgCode;
@property(nonatomic, copy)NSString * password;
@property(nonatomic, assign) NSInteger step;// 0 注册第一步 1 注册第二步
@end
