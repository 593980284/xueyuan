//
//  EDSPracticeHeaderView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDSQuestionModel;

@interface EDSPracticeHeaderView : UIView

/** 数据 */
@property (nonatomic, strong) EDSQuestionModel  *questionModel;

- (CGFloat)getPracticeHeaderViewHeight;

@end
