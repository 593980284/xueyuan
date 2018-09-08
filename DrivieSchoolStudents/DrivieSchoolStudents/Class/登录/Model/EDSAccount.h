//
//  EDSAccount.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSAccount : NSObject

/** 用户状态。游客：1，非游客：0 */
@property (nonatomic, copy) NSString *state;
/** 游客登录状态。首次登录：0，非首次登录：1 */
@property (nonatomic, copy) NSString *touristState;
/**  */
@property (nonatomic, copy) NSString *userID;
/** 头像 */
@property (nonatomic, copy) NSString *picUrl;
/** 展示图片 */
@property (nonatomic, copy) NSString *showPicUrl;
/** 展示图片 */
@property (nonatomic, copy) NSString *phone;

/** 科目一练习 */
@property (nonatomic, copy) NSString *firstSubjectID;

/** 本地经度 */
@property (nonatomic, assign) double localLng;
/** 本地纬度 */
@property (nonatomic, assign) double localLat;


- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
