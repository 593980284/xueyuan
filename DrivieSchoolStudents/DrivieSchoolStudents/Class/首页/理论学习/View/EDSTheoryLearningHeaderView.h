//
//  EDSTheoryLearningHeaderView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSTheoryLearningHeaderView : UIView
@property (nonatomic, copy) void (^headerDidSelectBtn)(NSString *string);
@end
