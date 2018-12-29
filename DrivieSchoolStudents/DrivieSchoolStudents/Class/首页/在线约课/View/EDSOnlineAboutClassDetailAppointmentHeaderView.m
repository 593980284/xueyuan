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
#import "LEEStarRating.h"

@interface EDSOnlineAboutClassDetailAppointmentHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *ageSubjectLbl;
@property (weak, nonatomic) IBOutlet UIImageView *logo1;
@property (weak, nonatomic) IBOutlet UIImageView *logo2;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
//@property (weak, nonatomic) IBOutlet EDSDriveStarView *driveStarView;
//@property (weak, nonatomic) IBOutlet UILabel *scoreLbl;

@property (nonatomic, strong)LEEStarRating *starView;


@property (weak, nonatomic) IBOutlet UILabel *coachNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *coachSubjectLbl;
@property (weak, nonatomic) IBOutlet UILabel *coachTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *coachhoursLbl;
@property (weak, nonatomic) IBOutlet UILabel *coachAppointmentNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *coachNoAppointmentNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalLb;

@end

@implementation EDSOnlineAboutClassDetailAppointmentHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self =  [[[NSBundle mainBundle] loadNibNamed:@"EDSOnlineAboutClassDetailAppointmentHeaderView" owner:self options:nil] lastObject];
        _starView = [[LEEStarRating alloc]initWithFrame:CGRectMake(0, 0, 80, 1) Count:5];
        _starView.maximumScore = 5;
        _starView.type = RatingTypeHalf;
        _starView.checkedImage = [UIImage imageNamed:@"star_content_icon_selected"];
        _starView.uncheckedImage = [UIImage imageNamed:@"star_content_icon_default"];
        [self addSubview:_starView];
        [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.height.mas_equalTo(8);
            make.width.mas_equalTo(110);
            make.right.mas_equalTo(self.mas_right).offset(-17.5);
        }];
    }
    return self;
}

- (void)setModel:(EDSOnlineClassListByDateModel *)model
{
    _model = model;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.showListImg] placeholderImage:AvatarPlaceholderImage];
    self.nameLbl.text = model.coachName;
    self.ageSubjectLbl.text = model.subjectName;
    self.starView.currentScore = model.showCoachStar;
   
//    self.numberRemainingLbl.text = model.showNoAppointmentNum;
//    self.driveStarView.selectNumber = model.showCoachStar;
//    self.scoreLbl.text = [NSString stringWithFormat:@"%@分",model.coachStar];
    
    
    self.coachNameLbl.text = model.schoolName;
    self.coachSubjectLbl.text = model.showSubjectAge;
    self.coachTimeLbl.text = model.periodTime;
    self.coachhoursLbl.text = [NSString stringWithFormat:@"%@小时",model.hours];
    self.coachAppointmentNumLbl.text = [NSString stringWithFormat:@"%@",model.appointmentNum];
    self.coachNoAppointmentNumLbl.text = model.noAppointmentNum;
    self.totalLb.text = model.maxNum;
    self.sexImage.image = [UIImage imageNamed:[model.coachSex isEqualToString:@"男"]?@"ic-man":@"ic-woman"];
    //    self.numberRemainingLbl.text = model.showNoAppointmentNum;
    NSArray *logs = [model.identity componentsSeparatedByString:@","];
    BOOL isJ = [logs containsObject:@"131000"];
    BOOL isS = [logs containsObject:@"132000"];
    if (isJ && isS) {
        self.logo1.hidden = NO;
        self.logo1.image = [UIImage imageNamed:@"ic-金牌教练"];
        self.logo2.hidden = NO;
        self.logo2.image = [UIImage imageNamed:@"ic-十佳党员"];
    }else if(!isS && !isJ){
        self.logo1.hidden = YES;
        self.logo2.hidden = YES;
    }else{
        self.logo1.hidden = NO;
        self.logo2.hidden = YES;
        self.logo1.image = [UIImage imageNamed:isJ ? @"ic-金牌教练": @"ic-十佳党员"];
    }
}



@end
