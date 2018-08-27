//
//  EDSStudentDriverStrategSubTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentDriverStrategSubTableViewCell.h"

@interface EDSStudentDriverStrategSubTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation EDSStudentDriverStrategSubTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=e025dacf76899e51678e3c1472a6d990/e824b899a9014c08bbd92197077b02087bf4f426.jpg"] placeholderImage:PLACEHOLDERGOODSIMAGE];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
