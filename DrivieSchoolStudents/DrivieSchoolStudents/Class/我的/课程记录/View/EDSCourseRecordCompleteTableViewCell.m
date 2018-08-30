//
//  EDSCourseRecordCompleteTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordCompleteTableViewCell.h"
#import "EDSDriveStarView.h"

@interface EDSCourseRecordCompleteTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *ageLbl;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet EDSDriveStarView *driveStarView;

@end

@implementation EDSCourseRecordCompleteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.ageLbl.layer.cornerRadius = 3;
    self.ageLbl.layer.masksToBounds = YES;
    self.ageLbl.layer.borderColor = SecondColor.CGColor;
    self.ageLbl.layer.borderWidth = 1;
    
    
    self.driveStarView.hidden = NO;
    self.statusLbl.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
