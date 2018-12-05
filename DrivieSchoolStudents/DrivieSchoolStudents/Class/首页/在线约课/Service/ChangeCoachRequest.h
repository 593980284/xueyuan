//
//  ChangeCoachRequest.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface ChangeCoachRequest : HQMBaseRequest
@property(nonatomic, copy)NSString* phone;
@property(nonatomic, copy)NSString* applyReason;
@property(nonatomic, copy)NSString* coachId;
@property(nonatomic, copy)NSString* classId;
@property(nonatomic, copy)NSString* subjectId
;
@end
