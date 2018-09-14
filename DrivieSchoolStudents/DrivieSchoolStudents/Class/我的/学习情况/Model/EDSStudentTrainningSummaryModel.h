//
//  EDSStudentTrainningSummaryModel.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/14.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSStudentTrainningSummaryModel : NSObject

@property (nonatomic , copy) NSString              * sub1UsedNetedu;            //科目一远程教学学时
@property (nonatomic , copy) NSString              * sub1SurplusHours;          //科目一剩余学时
@property (nonatomic , copy) NSString              * sub1UsedHours;             //科目一课堂教学学时

@property (nonatomic , copy) NSString              * sub2UsedDistence;          //科目二已学里程
@property (nonatomic , copy) NSString              * sub2Nonrecognitionhours;   //科目二无效学时
@property (nonatomic , copy) NSString              * sub2UsedHours;             //科目二实车学时
@property (nonatomic , copy) NSString              * sub2SurplusHours;          //科目二剩余学时
@property (nonatomic , copy) NSString              * sub2Nonrecognitiondistence;//科目二无效里程
@property (nonatomic , copy) NSString              * sub2UsedImitate;           //科目二模拟学时
@property (nonatomic , copy) NSString              * sub2SurplusDistence;       //科目二剩余里程

@property (nonatomic , copy) NSString              * sub3Nonrecognitionhours;   //科目三人脸无效学时
@property (nonatomic , copy) NSString              * sub3UsedDistence;          //科目三已学里程
@property (nonatomic , copy) NSString              * sub3UsedHours;             //科目三实车学时
@property (nonatomic , copy) NSString              * sub3SurplusHours;          //科目三剩余学时
@property (nonatomic , copy) NSString              * sub3SurplusDistence;       //科目三剩余里程
@property (nonatomic , copy) NSString              * sub3Nonrecognitiondistence;//科目三人脸无效里程
@property (nonatomic , copy) NSString              * sub3UsedImitate;           //科目三模拟学时

@property (nonatomic , copy) NSString              * sub4UsedNetedu;            //科目四远程教学学时
@property (nonatomic , copy) NSString              * sub4UsedHours;             //科目四课堂教学学时
@property (nonatomic , copy) NSString              * sub4SurplusHours;          //科目四剩余学时

@end
