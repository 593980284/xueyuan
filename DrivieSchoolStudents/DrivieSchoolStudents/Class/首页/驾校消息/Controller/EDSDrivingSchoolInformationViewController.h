//
//  EDSDrivingSchoolInformationViewController.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "BHYBaseViewController.h"

@interface EDSDrivingSchoolInformationViewController : BHYBaseViewController
@property(nonatomic, copy)void(^selectBlock)(NSString *schoolId, NSString *schoolName);

@end
