//
//  EDSSchoolRegionModel.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSSchoolRegionModel : NSObject

@property (nonatomic, copy) NSString *schoolId;     //驾校id
@property (nonatomic, copy) NSString *name;         //场地名称
@property (nonatomic, copy) NSString *address;      //地址
@property (nonatomic, copy) NSString *lngLat;
@property (nonatomic, copy) NSString *distance;

@property (nonatomic, copy) NSString *pointName;      //地址
@property (nonatomic, copy) NSString *pointAddress;
@property (nonatomic, copy) NSString *pointPhone;

@end
