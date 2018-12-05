//
//  EDSHomeTableViewHeaderView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EDSHomeTableViewHeaderViewDelegate <NSObject>

@optional

- (void)homeHeaderViewCycleScrollViewBackDict:(NSDictionary *)dict;

@end

@interface EDSHomeTableViewHeaderView : UIView

@property (nonatomic , strong) NSArray *headerArr;

@property(nonatomic , assign) BOOL is;

@property (nonatomic , weak) id<EDSHomeTableViewHeaderViewDelegate>delegate;
@end
