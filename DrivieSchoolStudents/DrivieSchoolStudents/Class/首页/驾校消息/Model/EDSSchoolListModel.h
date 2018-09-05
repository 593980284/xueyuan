//
//  EDSSchoolListModel.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/5.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSSchoolListModel : NSObject

/** 驾校id */
@property (nonatomic, copy) NSString *schoolId;
/** 驾校名称 */
@property (nonatomic, copy) NSString *schoolName;
/** 星级分数 */
@property (nonatomic, copy) NSString *starScore;
/** 驾校经纬度（121.326365,43.603852） */
@property (nonatomic, copy) NSString *lnglat;
/** App图片 */
@property (nonatomic, copy) NSString *appPhoto;
/** 驾校价格 */
@property (nonatomic, copy) NSString *carTypePrice;
/** 驾校距离 */
@property (nonatomic, copy) NSString *distance;
/** 驾校位置 */
@property (nonatomic, copy) NSString *address;

/** 展示价格 */
@property (nonatomic, copy) NSAttributedString  *showCartyoePrice;
/** 展示距离 */
@property (nonatomic, copy) NSString  *showDistance;
/** 展示分数 */
@property (nonatomic, assign) NSInteger showScore;
@end
