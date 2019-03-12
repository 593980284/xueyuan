//
//  SubjectTabbarRequest.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2019/3/5.
//  Copyright © 2019年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQMBaseRequest.h"
//"subjectName": "科目二",
//"subjectId": 2
@interface SubjectTabbarModel : NSObject
@property(nonatomic, strong)NSString *subjectName;
@property(nonatomic, strong)NSString *subjectId;
@end
NS_ASSUME_NONNULL_BEGIN

@interface SubjectTabbarRequest : HQMBaseRequest

@end

NS_ASSUME_NONNULL_END
