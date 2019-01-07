//
//  EDSOnlineAboutClassDetailAppointmentViewController.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//在线约课-详情页-预约

#import "BHYBaseViewController.h"
@class EDSOnlineClassListByDateModel;

@interface EDSOnlineAboutClassDetailAppointmentViewController : BHYBaseViewController
@property(nonatomic, assign)BOOL isKe;//是从课程进入的
@property(nonatomic, copy)NSString *appointmentId;
@property(nonatomic, copy)NSString *studentId;

@end
