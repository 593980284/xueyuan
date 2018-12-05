//
//  CoachModel.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/2.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoachModel : NSObject
@property (nonatomic , copy) NSString              * coachId;
@property (nonatomic , copy) NSString              * CoachName;
@property (nonatomic , assign) NSInteger               coachSex;
@property (nonatomic , copy) NSString              * teachAge;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * coachPhoto;
@property (nonatomic , copy) NSString              * coachPhone;
@property (nonatomic , copy) NSString              * studentId;
@property (nonatomic , copy) NSString              * classId;
@property (nonatomic , copy) NSString              * subjectId;
@property (nonatomic , copy) NSString              * isBind;
@property (nonatomic , copy) NSString              * identity;
@property (nonatomic , assign) NSInteger  coachStar;
@property (nonatomic , copy) NSString              * studentName;

@end
//
//"coachId": 140000001203,
//"CoachName": "赵秀兰",
//"coachSex": "101002",
//"teachAge": 2,
//"name": "科目二",
//"coachPhoto":"",
//"coachPhone": "15847488008",
//"studentId": 140000000061,
//"studentName": "陈会喜",
//"classId": 1,
//"subjectId": 2,
//"isBind": 2  ,
//"identity":"131000,132000"

