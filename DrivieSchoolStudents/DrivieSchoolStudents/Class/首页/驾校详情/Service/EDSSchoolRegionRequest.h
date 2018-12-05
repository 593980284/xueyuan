//
//  EDSSchoolRegionRequest.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface EDSSchoolRegionRequest : HQMBaseRequest

@property (nonatomic, copy) NSString *schoolId;//驾校id
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)BOOL findSchoolPoint;


@end
