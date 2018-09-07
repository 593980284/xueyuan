//
//  EDSDataBase.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/7.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EDSAnswerModel;
@class EDSQuestionModel;


@interface EDSDataBase : NSObject

+ (instancetype)sharedDataBase;

//随机获取科目一题目
- (EDSQuestionModel *)getRandomSubjectFirst;

@end

