//
//  EDSEDSDrivingDetailsHeaderView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDSSchoolInformationDetailModel;

@interface EDSEDSDrivingDetailsHeaderView : UICollectionReusableView
/** 数据 */
@property (nonatomic, strong) NSArray  *headerModel;

@property (assign, nonatomic) CGFloat itemHeight;

/** 驾校简介 */
@property (nonatomic, strong) UIView  *driveSchoolBgView;
/** 评分 */
@property (nonatomic, strong) UIView  *commentBgView;

@property (assign, nonatomic, getter=getSelectedItemIndex) NSInteger selectedItemIndex;

@property (nonatomic, copy) void (^drivingDetailsHeaderViewDidSelectStringback)(NSString *titleStr);
/** 地址 */
@property (nonatomic, strong) UILabel  *driveAddressLbl;

/** 展示数据 */
@property (nonatomic, strong) EDSSchoolInformationDetailModel  *informationDetailModel;

@end
