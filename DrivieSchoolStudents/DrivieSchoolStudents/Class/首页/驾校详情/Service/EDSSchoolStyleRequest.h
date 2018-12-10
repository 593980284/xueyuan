//
//  EDSSchoolStyleRequest.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//教学风采接口

#import "HQMBaseRequest.h"

@interface EDSSchoolStyleRequest : HQMBaseRequest

@property (nonatomic, copy) NSString *schoolId;//驾校id
@property (nonatomic, copy) NSString *phone;//手机号
@property (nonatomic, assign) NSInteger page;
@property(nonatomic, assign)NSInteger  rows;


@end
