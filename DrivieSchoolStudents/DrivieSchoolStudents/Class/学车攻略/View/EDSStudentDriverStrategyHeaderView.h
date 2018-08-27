//
//  EDSStudentDriverStrategyHeaderView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSStudentDriverStrategyHeaderView : UIView
@property (nonatomic, copy) void (^viewDidSelectBtnBlock)(NSString *backBlock);
@end
