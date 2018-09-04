//
//  EDSSubscribeApplyOneTableViewCell.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSSubscribeApplyOneTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *drivingSchoolLbl;
@property (weak, nonatomic) IBOutlet UILabel *carTypeLbl;

@property (nonatomic, copy) void (^subscribeApplyOneTableDidSelectStringback)(NSString *titleStr);

@end
