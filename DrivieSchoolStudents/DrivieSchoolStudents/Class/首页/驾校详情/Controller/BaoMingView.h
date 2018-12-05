//
//  BaoMingView.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class EDSEDSDrivingDetailsHeaderView;
@interface BaoMingView : UIView
@property (nonatomic, strong) EDSEDSDrivingDetailsHeaderView  *topView;

/** 学校id */
@property (nonatomic, copy) NSString *schoolId;

@end

NS_ASSUME_NONNULL_END
