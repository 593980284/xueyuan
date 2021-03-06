//
//  EDSMessageSiginBoxViewController.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/13.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDSStudentMsgModel;
@class EDSOnlineClassListByDateModel;

@interface EDSMessageSiginBoxViewController : UIViewController

@property (nonatomic , strong) EDSStudentMsgModel *msgModel;

@property (nonatomic, copy) void (^messageSiginBoxViewControllerDidClick)(EDSOnlineClassListByDateModel *model);
@end
