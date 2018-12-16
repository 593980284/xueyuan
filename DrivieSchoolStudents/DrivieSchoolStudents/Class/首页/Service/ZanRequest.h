//
//  ZanRequest.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/16.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"


@interface ZanRequest : HQMBaseRequest
@property(nonatomic, copy)NSString *styleId;
@property(nonatomic, copy)NSString *phone;
@property(nonatomic, copy)NSString *type;
@end


