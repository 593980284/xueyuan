//
//  EDSFirstSubjectExamBase.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSFirstSubjectExamBase : NSObject

+ (instancetype)sharedDataBase;


- (NSArray *)getFirstSubjectExam;
@end
