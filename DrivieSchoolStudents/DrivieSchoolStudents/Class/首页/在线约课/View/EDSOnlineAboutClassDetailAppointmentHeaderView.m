//
//  EDSOnlineAboutClassDetailAppointmentHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineAboutClassDetailAppointmentHeaderView.h"

#import "EDSDriveStarView.h"

#import "EDSOnlineClassListByDateModel.h"

@interface EDSOnlineAboutClassDetailAppointmentHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *ageSubjectLbl;
@property (weak, nonatomic) IBOutlet UILabel *sexLbl;
@property (weak, nonatomic) IBOutlet EDSDriveStarView *driveStarView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *numberRemainingLbl;


@property (weak, nonatomic) IBOutlet UILabel *coachNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *coachSubjectLbl;
@property (weak, nonatomic) IBOutlet UILabel *coachTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *coachhoursLbl;
@property (weak, nonatomic) IBOutlet UILabel *coachAppointmentNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *coachNoAppointmentNumLbl;

@end

@implementation EDSOnlineAboutClassDetailAppointmentHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSOnlineAboutClassDetailAppointmentHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}

- (void)setModel:(EDSOnlineClassListByDateModel *)model
{
    _model = model;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.showListImg] placeholderImage:PLACEHOLDERGOODSIMAGE];
    self.nameLbl.text = model.coachName;
    self.ageSubjectLbl.text = model.showSubjectAge;
    self.sexLbl.text = model.coachSex;
    self.numberRemainingLbl.text = model.showNoAppointmentNum;
    self.driveStarView.selectNumber = model.showCoachStar;
    self.scoreLbl.text = [NSString stringWithFormat:@"%@分",model.coachStar];
    
    
    self.coachNameLbl.text = model.schoolName;
    self.coachSubjectLbl.text = model.subjectName;
    self.coachTimeLbl.text = model.periodTime;
    self.coachhoursLbl.text = [NSString stringWithFormat:@"%@小时",model.hours];
    self.coachAppointmentNumLbl.text = model.appointmentNum;
    self.coachNoAppointmentNumLbl.text = model.noAppointmentNum;
}


- (instancetype)init
{
    return [self initWithFrame:self.frame];
}


@end
