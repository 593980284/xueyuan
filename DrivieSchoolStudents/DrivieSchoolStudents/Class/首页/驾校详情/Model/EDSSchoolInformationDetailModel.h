//
//  EDSSchoolInformationDetailModel.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSSchoolInformationDetailModel : NSObject

/** 驾校id */
@property (nonatomic, copy) NSString *schoolId;
/** 驾校名称 */
@property (nonatomic, copy) NSString *schoolName;
/** 地址 */
@property (nonatomic, copy) NSString *address;
/** 经纬度 */
@property (nonatomic, copy) NSString *lngLat;
/** 驾校图片 */
@property (nonatomic, copy) NSString *schoolPhoto;
/** 星级评分 */
@property (nonatomic, copy) NSString *starScore;
/** 价格 */
@property (nonatomic, copy) NSString *schoolPrice;
/** 联系电话 */
@property (nonatomic, copy) NSString *phone;
/** 驾校简介 */
@property (nonatomic, copy) NSString *appContent;

/** 展示图片 */
@property (nonatomic, copy) NSString *showSchoolPhoto;
/** 展示价格 */
@property (nonatomic, copy) NSString *showSchoolPrice;
/** 展示分数 */
@property (nonatomic, copy) NSString  *showStarScore;
/** 展示几星 */
@property (nonatomic, assign) NSInteger showStarScoreInterger;
/** 经度 */
@property (nonatomic, assign) double lng;
/** 纬度 */
@property (nonatomic, assign) double lat;

@end
