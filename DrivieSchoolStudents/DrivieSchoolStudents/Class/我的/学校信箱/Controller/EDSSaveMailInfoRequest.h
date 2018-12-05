//
//  EDSSaveMailInfoRequest.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/13.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface EDSSaveMailInfoRequest : HQMBaseRequest

@property (nonatomic , copy) NSString *phone;
@property (nonatomic , copy) NSString *type;//建议类型。  0:投诉信息 1:改进意见
@property (nonatomic , copy) NSString *pubContent;

@end
