//
//  ComplaintTableViewCell.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ComplaintTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *phoneLb;
@property (nonatomic , strong) CModel *model;

@end

NS_ASSUME_NONNULL_END
