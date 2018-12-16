//
//  SelectScrollView.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectScrollView : UIScrollView
- (instancetype)initWithTitles:(NSArray *)titles;
@property (nonatomic, copy) void (^block)(NSString *titleStr);
@end

NS_ASSUME_NONNULL_END
