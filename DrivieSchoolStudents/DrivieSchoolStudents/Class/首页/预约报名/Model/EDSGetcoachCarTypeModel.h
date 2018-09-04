//
//  EDSGetcoachCarTypeModel.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/4.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSGetcoachCarTypeModel : NSObject

@property (nonatomic, copy) NSString *carTypeCode;//培训车型码定义：00-无，01- A1，02-A2，03-A3，11-B1，12-B2，21-C1，22-C2，23-C3，24-C4，25-C5，31-D，32-E，33-F，41-M，42-N，43-P；
@property (nonatomic, copy) NSString *cardCode;//车型对应写入卡中的编码
@property (nonatomic, copy) NSString *code;//车型代码
@property (nonatomic, copy) NSString *ID;//Id号
@property (nonatomic, copy) NSString *name;//车型名称
@property (nonatomic, copy) NSString *sub1TotalDistance;//科目一总里程(米)
@property (nonatomic, copy) NSString *sub1TotalHours;//科目一总学时(秒)
@property (nonatomic, copy) NSString *sub2TotalDistance;//科目二总里程(米)
@property (nonatomic, copy) NSString *sub2TotalHours;//科目二总学时(秒)
@property (nonatomic, copy) NSString *sub3TotalDistance;//科目三总里程(米)
@property (nonatomic, copy) NSString *sub3TotalHours;//科目三总学时(秒)
@property (nonatomic, copy) NSString *sub4TotalDistance;//科目四总里程(米)
@property (nonatomic, copy) NSString *sub4TotalHours;//科目四总学时(秒)

@end
