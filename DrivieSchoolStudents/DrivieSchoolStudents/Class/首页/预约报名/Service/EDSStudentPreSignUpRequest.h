//
//  EDSStudentPreSignUpRequest.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface EDSStudentPreSignUpRequest : HQMBaseRequest

@property (nonatomic, copy) NSString *schoolId;         //驾校id
@property (nonatomic, copy) NSString *studentName;      //学员姓名
@property (nonatomic, copy) NSString *certNo;           //学员身份证号
@property (nonatomic, copy) NSString *mobile;           //学员手机号
@property (nonatomic, copy) NSString *applyDriveCar;    //学员申请车型
@property (nonatomic, copy) NSString *appointmentTime;  //预约时间
@property (nonatomic, copy) NSString *signupSource;     //预报名来源, 0:android 1:ios

@end
