//
//  EDSTheirPapersBoxViewController.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/11.
//  Copyright © 2018年 班文政. All rights reserved.
//交卷

#import <UIKit/UIKit.h>

@interface EDSTheirPapersBoxViewController : UIViewController

@property (nonatomic, assign) NSInteger correctCount;
@property (nonatomic, assign) NSInteger errortCount;

@property (nonatomic, copy) void (^theirPapersBoxViewBackDidBtnString)(NSString *string);

@end
