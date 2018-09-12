//
//  EDSOnlineAboutClassTableViewHeaderView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDSOnlineClassDateListModel;

@interface EDSOnlineAboutClassTableViewHeaderView : UIView

@property (nonatomic , strong) NSArray <EDSOnlineClassDateListModel *> *dataArr;

@property (nonatomic, copy) void (^onlineAboutClassTableViewHeaderViewDidBackData)(NSString *datastr);

@end
