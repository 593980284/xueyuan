//
//  BusListRequest.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2019/3/2.
//  Copyright © 2019年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BusListRequest : HQMBaseRequest
@property (nonatomic,copy)NSString  *type; // 1：首页访问 2:班车信息列表
@end

NS_ASSUME_NONNULL_END
