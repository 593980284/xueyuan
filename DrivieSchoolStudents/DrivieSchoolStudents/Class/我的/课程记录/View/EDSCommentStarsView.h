//
//  EDSCommentStarsView.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/15.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSCommentStarsView : UIView

@property (nonatomic, copy) void (^startBackNumber)(NSInteger  selectNumber);

@property (nonatomic, assign) NSInteger  selectNumber;

@end
