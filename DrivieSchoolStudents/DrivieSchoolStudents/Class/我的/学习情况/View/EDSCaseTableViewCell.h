//
//  EDSCaseTableViewCell.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/14.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDSStudentExamResultInfoModel;

@interface EDSCaseTableViewCell : UITableViewCell

@property (nonatomic ,strong) EDSStudentExamResultInfoModel *examModel;
@end
