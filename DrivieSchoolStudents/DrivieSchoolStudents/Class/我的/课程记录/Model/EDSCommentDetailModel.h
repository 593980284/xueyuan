//
//  EDSCommentDetailModel.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/15.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSBtnList:NSObject

@property (nonatomic , copy) NSString              * index;
@property (nonatomic , copy) NSString              * labelName;

@end

@interface EDSCommentDetailModel : NSObject

@property (nonatomic , copy) NSString              * coachHygieneScore;
@property (nonatomic , copy) NSString              * coachEvaluationContent;
@property (nonatomic , copy) NSString              * coachLabel;
@property (nonatomic , copy) NSString              * coachAbilityScore;
@property (nonatomic , copy) NSString              * coachAttitudeScore;
@property (nonatomic , copy) NSArray<EDSBtnList *>              * list;

@end
