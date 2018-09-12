//
//  EDSTopScrollView.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDSOnlineClassDateListModel;

@interface EDSTopScrollView : UIScrollView

@property (nonatomic , strong) NSArray <EDSOnlineClassDateListModel *> *dataArr;

@property (nonatomic, copy) void (^topScrollViewDidBackData)(NSString *datastr);

@end
