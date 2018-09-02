//
//  EDSEDSDrivingDetailsHeaderView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSEDSDrivingDetailsHeaderView : UICollectionReusableView
/** 数据 */
@property (nonatomic, strong) NSArray  *headerModel;

@property (assign, nonatomic) CGFloat itemHeight;


@property (assign, nonatomic, getter=getSelectedItemIndex) NSInteger selectedItemIndex;

@end
