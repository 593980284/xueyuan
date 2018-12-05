//
//  EDSHeaderPageButtonView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSHeaderPageButtonView : UIView
/** 按钮数组 */
@property (nonatomic, strong) NSArray  *btnArr;

@property (nonatomic, copy) void (^headerPageButtonDidSelectStringback)(NSString *titleStr);
@end
