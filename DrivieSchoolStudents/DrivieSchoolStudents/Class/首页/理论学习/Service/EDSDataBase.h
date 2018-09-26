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

#pragma mark ------------------------ 科目一 --------------------------------
/** 随机获取科目一题目 */
- (EDSQuestionModel *)getRandomSubjectFirst;
/** 科目一顺序做题 */
- (EDSQuestionModel *)getSubjectFirstQuestion;
/** 获取科目一一共多少题 */
- (NSString *)getOneFirstSubjectCount;
/** 根据id获取科目一题目 */
- (EDSQuestionModel *)getSubjectFirstQuestionWithID:(NSString *)ID;


/** 添加错题 */
- (void)upDateFirstSubjectErrorsWithID:(NSString *)ID;
/** 错题数 */
- (NSString *)getOneFirstSubjectErrorCount;
/** 获取科目一错题题目 */
- (EDSQuestionModel *)getFirstSubjectErrorWithID:(NSString *)ID;


/** 收藏 */
- (BOOL)upDataFirstSubjectCollectionWithID:(NSString *)ID;
/** 取消收藏 */
- (BOOL)upDataFirstSubjectunCollectionWithID:(NSString *)ID;
/** 获取收藏数量 */
- (NSString *)getFirstSubjectCollectionCount;
/** 获取科目一收藏题目 */
- (EDSQuestionModel *)getFirstSubjectCollectionWithID:(NSString *)ID;


/** 背题 */
- (EDSQuestionModel *)getFirstSubjectRecitePolitcsWithID:(NSString *)ID;


/** 清除科目一所有错题 */
- (void)clearFirstSubjectAllWrongQuestions;

//考试

//信号灯12 + 灯光16 20题目         SELECT *FROM classifyfristbean WHERE tagid = 12 OR tagid = 16 ORDER BY random() LIMIT 20
//速度7 + 距离8 + 手势11 25题      SELECT *FROM classifyfristbean WHERE tagid = 7 OR tagid = 8 OR tagid = 11 ORDER BY random() LIMIT 25
//酒驾14 + 罚款9 20题             SELECT *FROM classifyfristbean WHERE tagid = 14 OR tagid = 9 ORDER BY random() LIMIT 20
//仪表19 5题                     SELECT *FROM classifyfristbean WHERE tagid = 19 ORDER BY random() LIMIT 20
//其他 30题                      

@end

