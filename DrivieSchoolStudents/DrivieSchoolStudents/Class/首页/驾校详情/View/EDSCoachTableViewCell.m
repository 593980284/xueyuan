//
//  EDSCoachTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCoachTableViewCell.h"
#import "EDSDriveStarView.h"
#import "EDSCoachListModel.h"

@interface EDSCoachTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coachPhotoImgView;
@property (weak, nonatomic) IBOutlet UILabel *coachNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *coachDescrpLbl;
@property (weak, nonatomic) IBOutlet UILabel *coachSexLbl;
@property (weak, nonatomic) IBOutlet EDSDriveStarView *coachstarView;
@property (weak, nonatomic) IBOutlet UILabel *remainLbl;

@end

@implementation EDSCoachTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCoachModel:(EDSCoachListModel *)coachModel
{
    _coachModel = coachModel;
    
    [self.coachPhotoImgView sd_setImageWithURL:[NSURL URLWithString:coachModel.showCoachPhoto] placeholderImage:AvatarPlaceholderImage];
    
    self.coachNameLbl.text = coachModel.coachName;
    self.coachDescrpLbl.text = coachModel.showCoachDescrp;
    self.coachSexLbl.text = coachModel.coachSex;
    self.coachstarView.selectNumber = coachModel.showCoachStarInterger;
    self.remainLbl.text  = [NSString stringWithFormat:@"%@分",coachModel.coachStar];
}

@end
