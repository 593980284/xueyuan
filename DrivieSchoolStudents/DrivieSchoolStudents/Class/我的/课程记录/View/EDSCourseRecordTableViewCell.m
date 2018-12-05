//
//  EDSCourseRecordTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordTableViewCell.h"
#import "EDSCourseRecordModel.h"

@interface EDSCourseRecordTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *coachNameLbl;
//@property (weak, nonatomic) IBOutlet UIButton *agebtn;
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *periodTimeLbl;
//@property (weak, nonatomic) IBOutlet UILabel *subjecthourLbl;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *ageBtn;

@end

@implementation EDSCourseRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.ageBtn.layer.cornerRadius = 3;
    self.ageBtn.layer.masksToBounds = YES;
    self.ageBtn.layer.borderColor = SecondColor.CGColor;
    self.ageBtn.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCourseRecordModel:(EDSCourseRecordModel *)courseRecordModel
{
    _courseRecordModel = courseRecordModel;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:courseRecordModel.coachPhoto] placeholderImage:AvatarPlaceholderImage];
    
    self.coachNameLbl.text = courseRecordModel.coachName;
    self.coachNameLbl.font = kFont(16);
    
    self.schoolNameLbl.text = courseRecordModel.coachSex;
    
    self.ageBtn.text = [NSString stringWithFormat:@"  %@  ", courseRecordModel.teachType];
    self.lb1.text = [NSString stringWithFormat:@"总名额：%ld",courseRecordModel.maxNum];
     self.lb2.text = [NSString stringWithFormat:@"已预约：%ld",courseRecordModel.appointmentNum];
     self.lb3.text = [NSString stringWithFormat:@"剩余：%ld",courseRecordModel.noAppointmentNum];
//    CGFloat agebtnW = kScreenWidth - CGRectGetMaxX(self.coachNameLbl.frame) - 45 - [NSString sizeWithText:courseRecordModel.schoolName font:kFont(13) maxSize:CGSizeMake(MAXFLOAT, 15)].width;
//    CGFloat showSubjectAgeW = [NSString sizeWithText:courseRecordModel.showSubjectAge font:kFont(15) maxSize:CGSizeMake(MAXFLOAT, 15)].width + 5;
//    [self.agebtn mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(MIN(agebtnW, showSubjectAgeW), 15));
//    }];
//    self.agebtn.titleLabel.font = kFont(11);
    
    self.periodTimeLbl.text = courseRecordModel.periodTime;
//    self.subjecthourLbl.text = courseRecordModel.showSubjecthour;
    
//    [self layoutIfNeeded];
}

@end
