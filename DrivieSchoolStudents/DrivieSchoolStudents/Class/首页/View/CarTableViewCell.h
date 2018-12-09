//
//  CarTableViewCell.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/9.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarTableViewCell : UITableViewCell
@property(nonatomic, strong)UILabel *titleLb;
@property(nonatomic, strong)UILabel *detailLb;
@property(nonatomic, strong)UILabel *startTimeLb;
@property(nonatomic, strong)UILabel *endTimeLb;

@property(nonatomic, strong)NSDictionary *dic;
@end

NS_ASSUME_NONNULL_END
