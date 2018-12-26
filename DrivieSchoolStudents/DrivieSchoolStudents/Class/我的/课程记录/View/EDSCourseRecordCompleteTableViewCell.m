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
@property (weak, nonatomic) IBOutlet UILabel *ageLbl;

@property (weak, nonatomic) IBOutlet UILabel *coachNameLbl;
//@property (weak, nonatomic) IBOutlet UIButton *ageLbl;
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet UILabel *lastNUm;
@property (weak, nonatomic) IBOutlet UIImageView *logo1;
@property (weak, nonatomic) IBOutlet UIImageView *logo2;
@property (weak, nonatomic) IBOutlet UILabel *topStatus;
@property (weak, nonatomic) IBOutlet UILabel *bottomStatus;
@property (weak, nonatomic) IBOutlet UIImageView *sexImgView;

@end

@implementation EDSCourseRecordCompleteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.topStatus.layer.cornerRadius = 4;
    self.topStatus.clipsToBounds = YES;
    self.topStatus.layer.borderWidth = 0.5;
    self.bottomStatus.layer.cornerRadius = 4;
    self.bottomStatus.clipsToBounds = YES;
//    self.ageLbl.layer.cornerRadius = 3;
//    self.ageLbl.layer.masksToBounds = YES;
//    self.ageLbl.layer.borderColor = SecondColor.CGColor;
//    self.ageLbl.layer.borderWidth = 1;
    
  //  self.schoolNameLbl.hidden = YES;
//    self.driveStarView.hidden = NO;
//    self.statusLbl.hidden = YES;
}
- (IBAction)phonebtnTap:(id)sender {
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_courseRecordModel.coachPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)setCourseRecordModel:(EDSCourseRecordModel *)courseRecordModel
{
    
    self.logo1.hidden = YES;
    self.logo2.hidden = YES;
    self.sexImgView.image = [UIImage imageNamed:[courseRecordModel.coachSex  isEqualToString:@"女"]? @"ic-woman" :@"ic-man"];
    NSArray *logs = [courseRecordModel.identity componentsSeparatedByString:@","];
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
//    [@"已预约",@"学员签到",@"已完成",@"缺勤",@"未签到",@"等待确认",@"已完成",@"缺勤", @"已完成 - 未评价"]
    _courseRecordModel = courseRecordModel;
    switch ([courseRecordModel gethcStatus]) {
        case 0:
        { self.bottomStatus.hidden = NO;
            self.bottomStatus.text = @"已预约";
            self.bottomStatus.backgroundColor = RGBCOLOR(87,152,247);
          self.topStatus.hidden = YES;
        }
            break;
        case 1:
        { self.bottomStatus.hidden = NO;
            self.bottomStatus.text = @"签到";
            self.bottomStatus.backgroundColor = RGBCOLOR(133,189,98);
            self.topStatus.hidden = YES;
        }
            break;
        case 2:
        case 6:
        { self.bottomStatus.hidden = YES;
            self.topStatus.hidden = NO;
            self.topStatus.text = @"已完成";
            self.topStatus.layer.borderColor = RGBCOLOR(101,160,247).CGColor;
            self.topStatus.textColor = RGBCOLOR(101,160,247);
            self.topStatus.backgroundColor= RGBACOLOR(101,160,247,0.3);
        }
            break;
        case 3:
        case 7:
        {  self.bottomStatus.hidden = YES;
            self.topStatus.hidden = NO;
            self.topStatus.text = @"缺勤";
            self.topStatus.layer.borderColor = RGBCOLOR(229,57,44).CGColor;
            self.topStatus.textColor = RGBCOLOR(229,57,44);
            self.topStatus.backgroundColor= RGBACOLOR(229,57,44,0.3);
        }
            break;
        case 4:
        { self.bottomStatus.hidden = NO;
            self.bottomStatus.text = @"未签到";
            self.bottomStatus.backgroundColor = RGBCOLOR(241,145,54);
            self.topStatus.hidden = YES;
        }
            break;
        case 5:
        { self.bottomStatus.hidden = NO;
            self.bottomStatus.text = @"等待确认";
            self.bottomStatus.backgroundColor = RGBCOLOR(241,145,54);
            self.topStatus.hidden = YES;
        }
            break;
        case 8:
        { self.bottomStatus.hidden = NO;
            self.bottomStatus.text = @"去评价";
            self.bottomStatus.backgroundColor = RGBCOLOR(241,145,54);
            self.topStatus.hidden = YES;
        }
            break;
            
        default:
            break;
    }
 
//    self.statusLbl.attributedText = courseRecordModel.showStatus;
//    self.lastNUm.text = [NSString stringWithFormat:@"总名额：%ld",courseRecordModel.maxNum];
//
//    if ([courseRecordModel.status isEqual:@"2"] || [courseRecordModel.status isEqual:@"6"]) {
//
//        if (courseRecordModel.isComment) {
//
//            self.driveStarView.hidden = NO;
//            self.statusLbl.hidden = YES;
//            self.driveStarView.selectNumber = ceil([courseRecordModel.coachScore doubleValue]/2);
//        }else{
//
//            self.driveStarView.hidden = YES;
//            self.statusLbl.hidden = NO;
//        }
//    }else{
//
//        self.driveStarView.hidden = YES;
//        self.statusLbl.hidden = NO;
//    }
    self.coachNameLbl.text = courseRecordModel.coachName;
    self.coachNameLbl.font = kFont(16);
    
    self.ageLbl.text = [NSString stringWithFormat:@"%@：",courseRecordModel.teachType];
//    self.ageLbl.titleLabel.font = kFont(11);
    
//    CGFloat agebtnW = kScreenWidth - CGRectGetMaxX(self.coachNameLbl.frame) - 45 - [NSString sizeWithText:courseRecordModel.schoolName font:kFont(13) maxSize:CGSizeMake(MAXFLOAT, 15)].width;
//    CGFloat showSubjectAgeW = [NSString sizeWithText:courseRecordModel.showSubjectAge font:kFont(15) maxSize:CGSizeMake(MAXFLOAT, 15)].width + 5;
//    [self.ageLbl mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(MIN(agebtnW, showSubjectAgeW), 15));
//    }];
//    self.schoolNameLbl.text = courseRecordModel.coachSex;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:courseRecordModel.coachPhoto] placeholderImage:AvatarPlaceholderImage];
    
    self.timeLbl.text = courseRecordModel.periodTime;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
