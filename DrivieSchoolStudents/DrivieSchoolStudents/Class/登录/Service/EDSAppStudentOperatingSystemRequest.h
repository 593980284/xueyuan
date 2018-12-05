//
//  EDSAppStudentOperatingSystemRequest.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/6.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface EDSAppStudentOperatingSystemRequest : HQMBaseRequest

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *operatingSystem;


@end
