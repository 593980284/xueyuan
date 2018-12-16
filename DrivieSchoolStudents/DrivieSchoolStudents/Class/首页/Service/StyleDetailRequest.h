//
//  StyleDetailRequest.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/16.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface StyleDetailRequest : HQMBaseRequest
@property(nonatomic, copy)NSString *styleId;
@property(nonatomic, copy)NSString *phone;
@end

NS_ASSUME_NONNULL_END
