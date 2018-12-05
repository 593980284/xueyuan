//
//  EDSStudentChangePassWordRequest.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface EDSStudentChangePassWordRequest : HQMBaseRequest

@property (nonatomic , copy) NSString *phone;//手机号码
@property (nonatomic , copy) NSString *oldPassword;//手机号码
@property (nonatomic , copy) NSString *password;//手机号码

@end
