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
- (IBAction)phonebtnTap:(id)sender {
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_courseRecordModel.coachPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)setCourseRecordModel:(EDSCourseRecordModel *)courseRecordModel
{
    _courseRecordModel = courseRecordModel;
 
    self.statusLbl.attributedText = courseRecordModel.showStatus;
    self.lastNUm.text = [NSString stringWithFormat:@"总名额：%ld",courseRecordModel.maxNum];
    
    if ([courseRecordModel.status isEqual:@"2"] || [courseRecordModel.status isEqual:@"6"]) {
        
        if (courseRecordModel.isComment) {
            
            self.driveStarView.hidden = NO;
            self.statusLbl.hidden = YES;
            self.driveStarView.selectNumber = ceil([courseRecordModel.coachScore doubleValue]/2);
        }else{
            
            self.driveStarView.hidden = YES;
            self.statusLbl.hidden = NO;
        }
    }else{
        
        self.driveStarView.hidden = YES;
        self.statusLbl.hidden = NO;
    }
    self.coachNameLbl.text = courseRecordModel.coachName;
    self.coachNameLbl.font = kFont(16);
    
    self.ageLbl.text = [NSString stringWithFormat:@" %@ ",courseRecordModel.teachType];
//    self.ageLbl.titleLabel.font = kFont(11);
    
    CGFloat agebtnW = kScreenWidth - CGRectGetMaxX(self.coachNameLbl.frame) - 45 - [NSString sizeWithText:courseRecordModel.schoolName font:kFont(13) maxSize:CGSizeMake(MAXFLOAT, 15)].width;
    CGFloat showSubjectAgeW = [NSString sizeWithText:courseRecordModel.showSubjectAge font:kFont(15) maxSize:CGSizeMake(MAXFLOAT, 15)].width + 5;
//    [self.ageLbl mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(MIN(agebtnW, showSubjectAgeW), 15));
//    }];
    self.schoolNameLbl.text = courseRecordModel.coachSex;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:courseRecordModel.coachPhoto] placeholderImage:AvatarPlaceholderImage];
    
    self.timeLbl.text = courseRecordModel.periodTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
