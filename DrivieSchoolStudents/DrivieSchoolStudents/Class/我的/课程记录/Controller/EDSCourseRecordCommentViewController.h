//
//  EDSCourseRecordCommentViewController.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/31.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDSCourseRecordModel;

@interface EDSCourseRecordCommentViewController : UIViewController

@property (nonatomic, strong) EDSCourseRecordModel *courseRecordModel;

@property (nonatomic, assign) BOOL isCanEdit;
@end
