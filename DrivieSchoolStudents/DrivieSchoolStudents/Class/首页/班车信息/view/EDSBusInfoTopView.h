//
//  EDSBusInfoTopView.h
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/23.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDSBusInfoTopView : UIView

@property (nonatomic,strong) NSDictionary *dataDic;

@property (nonatomic,copy) void (^refreshBtnClick)(void);


@end

NS_ASSUME_NONNULL_END
