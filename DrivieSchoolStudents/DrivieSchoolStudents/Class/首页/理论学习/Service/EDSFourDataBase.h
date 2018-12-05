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


/** 获取科目四一共多少题 */
- (NSString *)getOneFourSubjectCount;
/** 科目四根据ID获取题目 */
- (EDSQuestionModel *)getFourSubjectQuestionWithID:(NSString *)ID;


/** 添加科目四错题 */
- (void)upDateFourSubjectErrorsWithID:(NSString *)ID;
/** 错题数 */
- (NSString *)getOneFourSubjectErrorCount;
/** 获取科目四错题题目 */
- (EDSQuestionModel *)getFourSubjectErrorWithID:(NSString *)ID;


/** 获取收藏数量 */
- (NSString *)getFourSubjectCollectionCount;
/** 获取科目四收藏题目 */
- (EDSQuestionModel *)getFourSubjectCollectionWithID:(NSString *)ID;


/** 收藏 */
- (BOOL)upDataFourSubjectCollectionWithID:(NSString *)ID;
/** 取消收藏 */
- (BOOL)upDataFourSubjectunCollectionWithID:(NSString *)ID;

/** 清除科目四所有错题 */
- (void)clearFourSubjectAllWrongQuestions;
@end
