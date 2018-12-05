//
//  EDSFirstView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDSEDSDrivingDetailsHeaderView;

@interface EDSFirstView : UIView

/** tableVuew */
@property (nonatomic, strong) EDSEDSDrivingDetailsHeaderView  *topView;

/** 简介数据 */
@property (nonatomic, copy) NSString *appContent;

@end
