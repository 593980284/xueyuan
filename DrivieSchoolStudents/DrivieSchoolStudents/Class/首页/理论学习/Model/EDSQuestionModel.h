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
/** 选择 */
@property (nonatomic, assign) BOOL isChoose;

@end

@interface EDSQuestionModel : NSObject

/** 标题 */
@property (nonatomic, copy) NSString  *questionTitle;
/** 图片 */
@property (nonatomic, copy) NSString *questionPictureUrl;
/** 是否是单选 */
@property (nonatomic, assign) BOOL isMultiple;

/** 答案列表 */
@property (nonatomic, strong) NSArray<EDSAnswerModel *>  *answerlists;

@end
