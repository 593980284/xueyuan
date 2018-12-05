//
//  EDSChooseBoxViewController.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/4.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSChooseBoxModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;


@end

@interface EDSChooseBoxViewController : UIViewController

/** 数据 */
@property (nonatomic, strong) NSArray<EDSChooseBoxModel *>  *modelArr;

@property (nonatomic, copy) void (^chooseBoxViewTableDidSelectModel)(EDSChooseBoxModel *model);

@end
