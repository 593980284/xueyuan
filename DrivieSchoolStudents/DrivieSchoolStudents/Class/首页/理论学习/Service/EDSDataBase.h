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
//科目一顺序做题
- (EDSQuestionModel *)getSubjectFirstQuestion;
//获取科目一一共多少题
- (NSString *)getOneFirstSubjectCount;
//获取科目一做错了多少题
- (NSString *)getOneFirstSubjectErrorCount;

//错题
- (void)upDateFirstSubjectErrorsWithID:(NSString *)ID;

//收藏
- (void)upDataFirstSubjectCollectionWithID:(NSString *)ID;
//取消收藏
- (void)upDataFirstSubjectunCollectionWithID:(NSString *)ID;

@end

