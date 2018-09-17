//
//  EDSQuestionModel.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSAnswerModel : NSObject

/**  */
@property (nonatomic, copy) NSString *answerTitle;
/** 第几题 */
@property (nonatomic, copy) NSString *answerR;
/** 真确选项 */
@property (nonatomic, assign) BOOL isCorrect;
/** 选择 */
@property (nonatomic, assign) BOOL isChoose;
/** 是否单选 */
@property (nonatomic, assign) BOOL isSubjectFour;
/** 是否查看答案 */
@property (nonatomic, assign) BOOL isLook;


@end

@interface EDSQuestionModel : NSObject

/** 标题 */
@property (nonatomic, copy) NSString  *questionTitle;
/** 图片 */
@property (nonatomic, copy) NSString *questionPictureUrl;
/** 正确答案 */
@property (nonatomic, copy) NSString *answer;
/** id */
@property (nonatomic, copy) NSString *ID;
/** 是否是单选 */
@property (nonatomic, assign) BOOL isMultiple;
/** 是否收藏 */
@property (nonatomic, assign) BOOL isCollection;

/** 答案列表 */
@property (nonatomic, strong) NSArray<EDSAnswerModel *>  *answerlists;

@end
