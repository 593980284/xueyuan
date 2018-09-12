//
//  EDSStrategyListRequest.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface EDSStrategyListRequest : HQMBaseRequest

@property (nonatomic , copy) NSString *strategyType;//必填，0考规，1技巧，2趣事
@property (nonatomic , copy) NSString *page;//类型

@end
