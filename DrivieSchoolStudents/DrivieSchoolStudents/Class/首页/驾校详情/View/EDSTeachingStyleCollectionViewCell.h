//
//  EDSTeachingStyleCollectionViewCell.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDSSchoolStyleModel;

@interface EDSTeachingStyleCollectionViewCell :UICollectionViewCell

/** 数据 */
@property (nonatomic, strong) EDSSchoolStyleModel  *styleModel;
@end

