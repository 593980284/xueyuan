//
//  EDSHomeTableViewCell.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDSDrivingSchoolModel;

@interface EDSHomeTableViewCell : UITableViewCell
/** 数据 */
@property (nonatomic, strong) NSArray  *cellArr;
/** 数据 */
@property (nonatomic, strong) EDSDrivingSchoolModel  *model;
@end
