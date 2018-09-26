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
@property (weak, nonatomic) IBOutlet UIButton *agebtn;
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *periodTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *subjecthourLbl;

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

- (void)setCourseRecordModel:(EDSCourseRecordModel *)courseRecordModel
{
    _courseRecordModel = courseRecordModel;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:courseRecordModel.coachPhoto] placeholderImage:PLACEHOLDERGOODSIMAGE];
    
    self.coachNameLbl.text = courseRecordModel.coachName;
    self.coachNameLbl.font = kFont(16);
    
    self.schoolNameLbl.text = courseRecordModel.schoolName;
    
    [self.agebtn setTitle:courseRecordModel.showSubjectAge forState:UIControlStateNormal];
    CGFloat agebtnW = kScreenWidth - CGRectGetMaxX(self.coachNameLbl.frame) - 45 - [NSString sizeWithText:courseRecordModel.schoolName font:kFont(13) maxSize:CGSizeMake(MAXFLOAT, 15)].width;
    CGFloat showSubjectAgeW = [NSString sizeWithText:courseRecordModel.showSubjectAge font:kFont(15) maxSize:CGSizeMake(MAXFLOAT, 15)].width + 5;
    [self.agebtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(MIN(agebtnW, showSubjectAgeW), 15));
    }];
    self.agebtn.titleLabel.font = kFont(11);
    
    self.periodTimeLbl.text = courseRecordModel.periodTime;
    self.subjecthourLbl.text = courseRecordModel.showSubjecthour;
    
    [self layoutIfNeeded];
}

@end
