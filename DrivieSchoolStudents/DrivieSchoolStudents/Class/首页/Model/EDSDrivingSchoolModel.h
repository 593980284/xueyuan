//
//  EDSDrivingSchoolModel.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSDrivingSchoolModel : NSObject

/** 驾校id */
@property (nonatomic, copy) NSString *schoolId;
/** 驾校名称 */
@property (nonatomic, copy) NSString *schoolName;
/** 驾校地址 */
@property (nonatomic, copy) NSString *address;
/** 经纬度 */
@property (nonatomic, copy) NSString *lngLat;
/** 驾校图片 */
@property (nonatomic, copy) NSString *schoolPhoto;
/** 是否为联盟内驾校 */
@property (nonatomic, assign) NSInteger isUnion;
/** 分数 */
@property (nonatomic, copy) NSString *starScore;
/** 价格 */
@property (nonatomic, copy) NSString *schoolPrice;

/** 是否是联盟内驾校 */
@property (nonatomic, assign) BOOL isUnionShow;
/** 距离 */
@property (nonatomic, copy) NSString *distance;
/** 经度 */
@property (nonatomic, assign) double lng;
/** 纬度 */
@property (nonatomic, assign) double lat;
/** 展示价格 */
@property (nonatomic, copy) NSAttributedString  *showSchoolPrice;
/** 展示分数 */
@property (nonatomic, assign) NSInteger showScore;

@property (nonatomic, assign) NSInteger  reputationLevel;
@end
