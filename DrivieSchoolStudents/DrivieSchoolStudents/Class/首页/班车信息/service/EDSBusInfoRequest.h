//
//  EDSBusInfoRequest.h
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/23.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface EDSBusInfoRequest : HQMBaseRequest
//0 qu 1 fan
@property (nonatomic,assign) NSInteger busInfoType;
@property (nonatomic,copy) NSString * busInfoId;

@end

NS_ASSUME_NONNULL_END
