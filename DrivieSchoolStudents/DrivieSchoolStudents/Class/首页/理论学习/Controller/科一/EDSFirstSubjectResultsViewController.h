//
//  EDSFirstSubjectResultsViewController.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/11.
//  Copyright © 2018年 班文政. All rights reserved.
//科一成绩

#import <UIKit/UIKit.h>

@interface EDSFirstSubjectExamResultModel : NSObject

@property (nonatomic , copy) NSString *time;        //时间
@property (nonatomic , copy) NSString *right;       //对
@property (nonatomic , copy) NSString *errors;      //错
@property (nonatomic , assign) BOOL isFour;         //是否是科目四

@end


@interface EDSFirstSubjectResultsViewController : UIViewController

@property (nonatomic , strong) EDSFirstSubjectExamResultModel *resultModel;
@property (nonatomic , strong) NSArray *errorsArr;

@end
