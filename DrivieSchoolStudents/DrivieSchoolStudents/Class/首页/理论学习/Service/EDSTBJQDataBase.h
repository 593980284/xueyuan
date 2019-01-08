//
//  EDSTBJQDataBase.h
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2019/1/6.
//  Copyright © 2019 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDSTBJQDataBase : NSObject
+ (instancetype)sharedDataBase;

-(NSArray *)getTuBiaoArr;

-(NSArray * )getTuBiaoWithCid:(long)cid andlimit:(NSInteger)limit;

//获取道路图标
-(NSArray *)getDaoLuTuBaio;

//汽车仪表
-(NSArray *)getQiCheYiBiao;

//车内功能按键
-(NSArray *)getCheNeiGongNengJian;

//交通事故
-(NSArray *)getJiaoTongShiGu;

@end

NS_ASSUME_NONNULL_END
