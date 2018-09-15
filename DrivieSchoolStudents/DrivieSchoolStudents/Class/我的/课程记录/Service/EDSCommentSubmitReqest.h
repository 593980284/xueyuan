//
//  EDSCommentSubmitReqest.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/15.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface EDSCommentSubmitReqest : HQMBaseRequest

@property (nonatomic , copy) NSString *courseRecordId;                      //约课记录id
@property (nonatomic , copy) NSString *coachAbilityScore;                   //教练教学能力评分
@property (nonatomic , copy) NSString *coachAttitudeScore;                  //教练服务态度评分
@property (nonatomic , copy) NSString *coachHygieneScore;                   //教练车辆卫生评分
@property (nonatomic , copy) NSString *coachLabel;                          //被选的标签index， 英文逗号分割
@property (nonatomic , copy) NSString *coachEvaluationContent;              //课程评价内容

@end
