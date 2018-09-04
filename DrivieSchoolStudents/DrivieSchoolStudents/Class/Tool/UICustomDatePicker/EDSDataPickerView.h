//
//  EDSDataPickerView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/4.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSDataPickerView : UIView

@property (nonatomic, copy) void (^dataPickerViewBackString)(NSString *titleStr);
@end
