//
//  SubjectListRequest.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2019/3/6.
//  Copyright © 2019年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubjectListRequest : HQMBaseRequest
@property(nonatomic, strong)NSString *date;
@property(nonatomic, strong)NSString *subjectId;
@end

NS_ASSUME_NONNULL_END
