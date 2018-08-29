//
//  EDSCourseRecordTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordTableViewCell.h"

@interface EDSCourseRecordTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *agebtn;

@end

@implementation EDSCourseRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.agebtn.layer.cornerRadius = 3;
    self.agebtn.layer.masksToBounds = YES;
    self.agebtn.layer.borderColor = SecondColor.CGColor;
    self.agebtn.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
