//
//  EDSCoachListModel.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSCoachListModel : NSObject

@property (nonatomic, copy) NSString *approveTeachCars; //准教车型
@property (nonatomic, copy) NSString *carNo;            //绑定车辆
@property (nonatomic, copy) NSString *coachId;          //教练id
@property (nonatomic, copy) NSString *coachName;        //教练姓名
@property (nonatomic, copy) NSString *coachPhoto;       //图片
@property (nonatomic, copy) NSString *coachSex;         //教练性别
@property (nonatomic, copy) NSString *coachStar;        //教练星级
@property (nonatomic, copy) NSString *teachAge;         //教龄
@property (nonatomic, copy) NSString *teachType;        //准教类型



@property (nonatomic, copy) NSString *showCoachPhoto;                   //展示图片
@property (nonatomic, assign) NSInteger showCoachStarInterger;          //展示图片
@property (nonatomic, copy) NSString *showCoachDescrp;                   //展示图片
@end
