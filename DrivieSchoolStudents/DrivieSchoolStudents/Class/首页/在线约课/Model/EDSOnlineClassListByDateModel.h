//
//  EDSOnlineClassListByDateModel.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSOnlineClassListByDateModel : NSObject

@property (nonatomic , copy) NSString              * teachAge;//教龄
@property (nonatomic , copy) NSString              * teachType;//教练科目
@property (nonatomic , copy) NSString              * periodTime;//约课时间段("2018-09-05 17:00-19:00")
@property (nonatomic , copy) NSString              * schoolId;//驾校id
@property (nonatomic , copy) NSString              * isAppointment;//是否预约 -1未预约 0已预约 1已签到
@property (nonatomic , copy) NSString              * hours;
@property (nonatomic , copy) NSString              * present;//教练简介
@property (nonatomic , copy) NSString              * coachSex;//教练性别
@property (nonatomic , copy) NSString              * appointmentId;//约课id
@property (nonatomic , copy) NSString              * appointmentNum;//报名人数
@property (nonatomic , copy) NSString              * coachName;//驾校名称
@property (nonatomic , copy) NSString              * shortPeriodTime;//约课时间段("17:00-19:00")
@property (nonatomic , copy) NSString              * schoolName;
@property (nonatomic , copy) NSString              * noAppointmentNum;//剩余人数
@property (nonatomic , copy) NSString              * coachPhoto;
@property (nonatomic , copy) NSString              * coachStar;//教练评分
@property (nonatomic , copy) NSString              * studentId;//学员id
@property (nonatomic , copy) NSString              * subjectName;//科目名称

@end
