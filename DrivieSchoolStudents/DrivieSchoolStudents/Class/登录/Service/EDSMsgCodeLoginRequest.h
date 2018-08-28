//
//  EDSMsgCodeLoginRequest.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface EDSMsgCodeLoginRequest : HQMBaseRequest

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *msgCode;

@end
