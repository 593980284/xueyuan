//
//  MineTopBarView.h
//  DrivieSchoolStudents
//
//  Created by kkmm on 2018/12/16.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineTopBarView : UIView
@property (nonatomic, copy) void (^headerImgViewDidClick)(void);

/** <#简介#> */
@property (nonatomic, strong) NSArray  *headerArr;
@end

NS_ASSUME_NONNULL_END
