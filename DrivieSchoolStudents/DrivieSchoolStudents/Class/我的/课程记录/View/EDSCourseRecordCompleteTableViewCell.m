//
//  EDSCourseRecordCompleteTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordCompleteTableViewCell.h"
#import "EDSDriveStarView.h"

#import "EDSCourseRecordModel.h"

@interface EDSCourseRecordCompleteTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet EDSDriveStarView *driveStarView;

@property (weak, nonatomic) IBOutlet UILabel *coachNameLbl;
@property (weak, nonatomic) IBOutlet UIButton *ageLbl;
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLbl;

@end

@implementation EDSCourseRecordCompleteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.ageLbl.layer.cornerRadius = 3;
    self.ageLbl.layer.masksToBounds = YES;
    self.ageLbl.layer.borderColor = SecondColor.CGColor;
    self.ageLbl.layer.borderWidth = 1;
    
    
//    self.driveStarView.hidden = NO;
//    self.statusLbl.hidden = YES;
}

- (void)setCourseRecordModel:(EDSCourseRecordModel *)courseRecordModel
{
    _courseRecordModel = courseRecordModel;
    
    if (courseRecordModel.coachScore.length > 0) {
        
        self.driveStarView.hidden = NO;
        self.statusLbl.hidden = YES;
        self.driveStarView.selectNumber = ceil([courseRecordModel.coachScore doubleValue]/2);
    }else{
        
        self.driveStarView.hidden = YES;
        self.statusLbl.hidden = NO;
        
        self.statusLbl.text = courseRecordModel.showStatus;
    }
    
    self.coachNameLbl.text = courseRecordModel.coachName;
    [self.ageLbl setTitle:courseRecordModel.showSubjectAge forState:UIControlStateNormal];
    self.schoolNameLbl.text = courseRecordModel.schoolName;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:courseRecordModel.coachPhoto] placeholderImage:PLACEHOLDERGOODSIMAGE];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
