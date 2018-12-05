//
//  EDSClearRecordViewController.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/10.
//  Copyright © 2018年 班文政. All rights reserved.
//清除记录

#import <UIKit/UIKit.h>

@interface EDSClearRecordViewController : UIViewController

/** 做了多少题 */
@property (nonatomic, copy) NSString *allCount;
/** 正确题目 */
@property (nonatomic, copy) NSString *errorsCount;
/** 错误题目 */
@property (nonatomic, copy) NSString *correctCount;

@property (nonatomic, copy) void (^clearRecordDidCommitBtn)(void);
@end
