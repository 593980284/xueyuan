//
//  EDSHomeSchoolInformationRequest.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface EDSHomeSchoolInformationRequest : HQMBaseRequest

@property (nonatomic, copy) NSString *schoolId;
@property (nonatomic, assign) NSInteger page;

@end
