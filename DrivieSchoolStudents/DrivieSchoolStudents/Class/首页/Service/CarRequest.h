//
//  CarRequest.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/9.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface CarRequest : HQMBaseRequest
@property(nonatomic, copy)NSString *phone;
@property(nonatomic, copy)NSString *type;
@end

NS_ASSUME_NONNULL_END
