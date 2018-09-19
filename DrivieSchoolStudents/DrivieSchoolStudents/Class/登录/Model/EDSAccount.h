//
//  EDSAccount.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSAccount : NSObject



@property (nonatomic , copy) NSString              * phone;//电话号码
@property (nonatomic , copy) NSString              * schoolId;//驾校id
@property (nonatomic , copy) NSString              * userID;//学员用户id
@property (nonatomic , copy) NSString              * learnProgress;//正在学习科目。0初始化 1科目一 2科目二 3科目三 4科目四 23科目二三
@property (nonatomic , copy) NSString              * schoolName;//驾校姓名
@property (nonatomic , copy) NSString              * photo;//头像路径
@property (nonatomic , copy) NSString              * state;//用户状态。游客：1，非游客：0
@property (nonatomic , copy) NSString              * applyDriveCar;//学员申请车型
@property (nonatomic , copy) NSString              * studentId;//学员id

/** 科目一练习 */
@property (nonatomic, copy) NSString *firstSubjectID;
/** 科目一背题 */
@property (nonatomic, copy) NSString *firstSubjectRecitedPoliticeID;


/** 科目四练习 */
@property (nonatomic, copy) NSString *fourSubjectID;
/** 科目四背题 */
@property (nonatomic, copy) NSString *fourSubjectRecitedPoliticeID;

/** 本地经度 */
@property (nonatomic, assign) double localLng;
/** 本地纬度 */
@property (nonatomic, assign) double localLat;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
