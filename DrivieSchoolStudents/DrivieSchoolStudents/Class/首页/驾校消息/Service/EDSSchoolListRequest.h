//
//  EDSSchoolListRequest.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/5.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface EDSSchoolListRequest : HQMBaseRequest

@property (nonatomic, copy) NSString *order;        //类型：0：联盟驾校，1：按距离，2：按价格
@property (nonatomic, copy) NSString *schoolName;   //学校名称
@property (nonatomic, copy) NSString *lng;          //经度
@property (nonatomic, copy) NSString *lat;          //纬度

@end
