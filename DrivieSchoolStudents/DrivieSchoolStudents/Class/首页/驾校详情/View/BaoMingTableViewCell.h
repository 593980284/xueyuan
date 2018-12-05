//
//  BaoMingTableViewCell.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDSSchoolRegionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaoMingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *telLb;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UILabel *distanceLb;

/** shuj */
@property (nonatomic, strong) EDSSchoolRegionModel  *regionModel;

@end

NS_ASSUME_NONNULL_END
