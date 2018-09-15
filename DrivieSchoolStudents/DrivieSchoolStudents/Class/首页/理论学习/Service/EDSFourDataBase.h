//
//  EDSFourDataBase.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/15.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EDSAnswerModel;
@class EDSQuestionModel;

@interface EDSFourDataBase : NSObject

+ (instancetype)sharedDataBase;

/** 科目四根据ID获取题目 */
- (EDSQuestionModel *)getFourSubjectQuestionWithID:(NSString *)ID;

@end
