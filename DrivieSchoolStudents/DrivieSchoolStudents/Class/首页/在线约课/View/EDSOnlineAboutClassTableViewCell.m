//
//  EDSOnlineAboutClassTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineAboutClassTableViewCell.h"
#import "EDSDriveStarView.h"

#import "EDSOnlineClassListByDateModel.h"

@interface EDSOnlineAboutClassTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *subjectLbl;
@property (weak, nonatomic) IBOutlet EDSDriveStarView *driveStarView;
@property (weak, nonatomic) IBOutlet UILabel *numberRemainingLbl;
@property (weak, nonatomic) IBOutlet UILabel *sexLbl;

@end

@implementation EDSOnlineAboutClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(EDSOnlineClassListByDateModel *)model
{
    _model = model;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.showListImg] placeholderImage:PLACEHOLDERGOODSIMAGE];
    self.nameLbl.text = model.coachName;
    self.subjectLbl.text = model.showSubjectTime;
    self.driveStarView.selectNumber = model.showCoachStar;
    self.sexLbl.text = model.coachSex;
    self.numberRemainingLbl.text = model.showNoAppointmentNum;
}

@end
