//
//  CarLocationRequest.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2019/3/9.
//  Copyright © 2019年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"
//"longitude": 117.240472,
//"latitude": 31.794182,
//"direction": 0,
//"gpsDate": 1551253841,
//"carNo": "皖A00111"
@interface CarLocationModel : NSObject
@property(nonatomic, strong)NSString * gpsDate;
@property(nonatomic, strong)NSString * carNo;
@property(nonatomic, assign)CGFloat  latitude;
@property(nonatomic, assign)CGFloat  longitude;
@property(nonatomic, assign)CGFloat  direction;

@end
NS_ASSUME_NONNULL_BEGIN

@interface CarLocationRequest : HQMBaseRequest
@property(nonatomic, strong)NSString * busId;
@end

NS_ASSUME_NONNULL_END
