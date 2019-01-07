//
//  LessonDetailsRequest.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LessonDetailsRequest : HQMBaseRequest
@property(nonatomic, copy)NSString *appointmentId;
@property(nonatomic, copy)NSString *studentId;
@end

NS_ASSUME_NONNULL_END
