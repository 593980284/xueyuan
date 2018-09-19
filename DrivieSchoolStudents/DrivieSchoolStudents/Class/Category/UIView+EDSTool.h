//
//  UIView+EDSTool.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/19.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (EDSTool)

//通过响应者链条获取view所在的控制器
- (UIViewController *)parentController;

@end

NS_ASSUME_NONNULL_END
