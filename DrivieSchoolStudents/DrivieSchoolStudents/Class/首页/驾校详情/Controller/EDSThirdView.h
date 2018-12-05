//
//  EDSThirdView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDSEDSDrivingDetailsHeaderView;
@interface EDSThirdView : UIView

@property (nonatomic, strong) EDSEDSDrivingDetailsHeaderView  *topView;
@property (nonatomic, strong) UIViewController  *parentView;

/** 学校id */
@property (nonatomic, copy) NSString *schoolId;



@end
