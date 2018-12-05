//
//  EDSSubscribeApplyTwoTableViewCell.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSSubscribeApplyTwoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UITextField *nameTextF;
@property (weak, nonatomic) IBOutlet UITextField *codeTextF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;

@property (nonatomic, copy) void (^subscribeApplyTwoTableDidSelectStringback)(NSString *titleStr);
@end
