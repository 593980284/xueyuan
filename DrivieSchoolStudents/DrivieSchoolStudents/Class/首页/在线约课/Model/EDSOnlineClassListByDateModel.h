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
@property (nonatomic , copy) NSString              * coachName;//教练名称
@property (nonatomic , copy) NSString              * shortPeriodTime;//约课时间段("17:00-19:00")
@property (nonatomic , copy) NSString              * schoolName;
@property (nonatomic , copy) NSString              * noAppointmentNum;//剩余人数
@property (nonatomic , copy) NSString              * coachPhoto;
@property (nonatomic , copy) NSString              * coachStar;//教练评分
@property (nonatomic , copy) NSString              * studentId;//学员id
@property (nonatomic , copy) NSString              * subjectName;//科目名称
@property (nonatomic , copy) NSString              * advanceSignInTime;//开课前多少时间可以课程签到(分钟)
@property (nonatomic , copy) NSString              * advanceCancelHours;//提前取消预课小时数



@property (nonatomic , copy) NSString              * showListImg;//列表展示图片
@property (nonatomic , copy) NSString              * showSubjectTime;//列表展示科目和时间
@property (nonatomic , copy) NSString              * showSubjectAge;//列表展示科目和教龄
@property (nonatomic , copy) NSString              * showNoAppointmentNum;//列表展示剩余人数
@property (nonatomic , strong) NSDate              * startSiginDate;//开始签到时间
@property (nonatomic , strong) NSDate              * endSiginDate;//结束签到时间
@property (nonatomic , strong) NSDate              * cancleAppDate;//取消预约时间
@property (nonatomic , assign) NSInteger             showCoachStar;//列表展示星级


@end
