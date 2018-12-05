//
//  EDSCourseRecordDetailDownView.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/14.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDSCourseRecordModel;

@interface EDSCourseRecordDetailDownView : UIView

@property (nonatomic, strong) EDSCourseRecordModel *courseRecordModel;

@property (nonatomic, copy) void (^courseRecordDetailDownViewDidButtonBackTitle)(NSString *title);

@end
