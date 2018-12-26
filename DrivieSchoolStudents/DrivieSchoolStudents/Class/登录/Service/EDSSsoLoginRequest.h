//
//  EDSSsoLoginRequest.h
//  DrivieSchoolStudents
//
//  Created by kkmm on 2018/12/26.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDSSsoLoginRequest : HQMBaseRequest
@property (nonatomic, copy) NSString *openId;

@property (nonatomic, copy) NSString *type;
@end

NS_ASSUME_NONNULL_END
