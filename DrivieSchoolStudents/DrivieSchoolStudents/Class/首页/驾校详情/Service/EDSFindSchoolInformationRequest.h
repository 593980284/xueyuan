//
//  EDSFindSchoolInformationRequest.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//驾校详情接口

#import "HQMBaseRequest.h"

@interface EDSFindSchoolInformationRequest : HQMBaseRequest
/** 驾校id */
@property (nonatomic, copy) NSString *schoolId;
@end
