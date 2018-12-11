//
//  EDSMsgCell.h
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/9.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDSStudentMsgModel.h"



@interface EDSMsgCell : UITableViewCell

@property (nonatomic,strong) UIView *view;
@property (nonatomic,strong) EDSStudentMsgModel *model;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end


