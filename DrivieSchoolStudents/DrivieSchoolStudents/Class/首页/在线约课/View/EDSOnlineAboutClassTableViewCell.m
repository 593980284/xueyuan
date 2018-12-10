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
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@property (weak, nonatomic) IBOutlet UILabel *numLb;


@end

@implementation EDSOnlineAboutClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgView.layer.masksToBounds = YES;
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
    self.driveStarView.hidden = YES;
//    self.totalLb.text = [NSString stringWithFormat:@"总名额：%@",model.maxNum];
//    self.useEd.text = [NSString stringWithFormat:@"已预约：%@",model.appointmentNum];
    self.sexImage.image = [UIImage imageNamed:[model.coachSex isEqualToString:@"男"]?@"ic-man":@"ic-woman"];
//    self.numberRemainingLbl.text = model.showNoAppointmentNum;
    if ( model.showNoAppointmentNum == 0) {
        self.numLb.text = @"约满";
        self.numLb.backgroundColor = [UIColor colorWithRed:100/255.0 green:150/255.0 blue:240/255.0 alpha:1];
    }else{
      self.numLb.text = [NSString stringWithFormat:@"约课(%@/%@)",model.appointmentNum, model.maxNum];
      self.numLb.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    }
}
@end
