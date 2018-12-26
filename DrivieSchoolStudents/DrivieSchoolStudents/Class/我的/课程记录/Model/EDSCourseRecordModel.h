//
//  EDSCourseRecordModel.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/13.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSCourseRecordModel : NSObject

@property (nonatomic , copy) NSString              * teachAge;      //教龄
@property (nonatomic , copy) NSString              * reachStuNum;   //到达学员
@property (nonatomic , copy) NSString              * periodTime;    //约课时间段("2018-09-05 17:00-19:00")
@property (nonatomic , copy) NSString              * coachPhone;
@property (nonatomic , copy) NSString              * schoolId;      //驾校id
@property (nonatomic , copy) NSString              * teachType;     //教练科目
@property (nonatomic , copy) NSString              * hours;         //课程时长
@property (nonatomic , copy) NSString              * courseRecordId;//约课id
@property (nonatomic , copy) NSString              * coachSex;      //教练性别
@property (nonatomic , copy) NSString              * appointmentId; //课程id
@property (nonatomic , copy) NSString              * coachName;     //教练名称
@property (nonatomic , copy) NSString              * subjectName;   //科目名称
@property (nonatomic , copy) NSString              * noReachStuNum; //未到达学员
@property (nonatomic , copy) NSString              * schoolName;    //驾校名称
@property (nonatomic , copy) NSString              * coachPhoto;    //教练头像
@property (nonatomic , copy) NSString              * coachScore;    //教练评分
@property (nonatomic , copy) NSString              * status;        //状态 2，6：已到（有分数显示分数，没分数显示待评价） 3，7：缺勤（显示缺勤） 0，1，4：未确认（显示未确认） 5：未确认（显示教练补签，在详情页面显示确认到课、我没有来按钮）
@property (nonatomic , copy) NSString              * studentId;     //学员id
@property (nonatomic , assign) BOOL                 isComment;    //判断是否评价
@property (nonatomic , copy)NSString *identity;



@property (nonatomic , copy) NSString              * showSubjectAge;
@property (nonatomic , copy) NSString              * showSubjecthour;
@property (nonatomic , copy) NSAttributedString              * showStatus;
@property (nonatomic , assign) NSInteger  maxNum;
@property (nonatomic , assign) NSInteger  appointmentNum;
@property (nonatomic , assign) NSInteger  noAppointmentNum;
- (NSInteger)gethcStatus;//返回我处理好的status
@end
