//
//  EDSOnlineAboutClassHeaderView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSOnlineAboutClassHeaderView : UIView

@property (nonatomic, copy) void (^onlineAboutClassHeaderViewBackTitleStr)(NSString *headerTitlestr);

@end
