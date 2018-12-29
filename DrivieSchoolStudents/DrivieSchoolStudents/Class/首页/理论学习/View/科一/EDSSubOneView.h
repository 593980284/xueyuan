//
//  EDSSubOneView.h
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/28.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDSSubOneView : UIView
//0 s顺序学习 1随机学习 2专项练习 3我的错题 4图标技巧 5 模拟考试
@property (nonatomic,copy) void (^btnClickBlock)(NSInteger indexType);


@end

NS_ASSUME_NONNULL_END
