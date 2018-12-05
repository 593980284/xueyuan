//
//  EDSSchoolListRequest.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/5.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface EDSSchoolListRequest : HQMBaseRequest

//@property (nonatomic, copy) NSString *order;        //类型：0：联盟驾校，1：按距离，2：按价格
@property (nonatomic, copy) NSString *schoolName;   //学校名称
@property (nonatomic, copy) NSString *longitude;          //经度
@property (nonatomic, copy) NSString *latitude;          //纬度
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy)NSString *orderType;
@property (nonatomic, copy)NSString *regionCode;
@property (nonatomic, copy)NSString *schoolType;


@end
