//
//  EDSCourseRecordDetailFooterView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/31.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordDetailFooterView.h"
#import "EDSCourseRecordModel.h"

@interface EDSCourseRecordDetailFooterView ()

@property (weak, nonatomic) IBOutlet UILabel *schoolNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *subjectNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *periodTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *hoursLbl;
@property (weak, nonatomic) IBOutlet UILabel *reachStuNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *noReachStuNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *carLB;

@end

@implementation EDSCourseRecordDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSCourseRecordDetailFooterView" owner:self options:nil] lastObject];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

- (void)setCourseRecordModel:(EDSCourseRecordModel *)courseRecordModel
{
    _courseRecordModel = courseRecordModel;
    
    self.schoolNameLbl.text = courseRecordModel.schoolName;
    self.subjectNameLbl.text = courseRecordModel.subjectName;
    self.periodTimeLbl.text = [courseRecordModel.periodTime componentsSeparatedByString:@" "].firstObject;
     self.periodTimeLbl.text = [courseRecordModel.periodTime componentsSeparatedByString:@" "].lastObject;
    self.timeLb.text = [NSString stringWithFormat:@"%@小时",courseRecordModel.hours];
    self.carLB.text =
    self.reachStuNumLbl.text = [NSString stringWithFormat:@"%ld",courseRecordModel.maxNum];
    self.noReachStuNumLbl.text = [NSString stringWithFormat:@"%ld",courseRecordModel.appointmentNum];
    self.lb3.text = [NSString stringWithFormat:@"%ld",courseRecordModel.noAppointmentNum];
//    NSMutableAttributedString * str = [courseRecordModel.showStatus mutableCopy];
//    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, courseRecordModel.showStatus.length)];
//    self.lb4.attributedText = str;
    self.lb4.layer.borderWidth = 1;
    self.lb4.layer.cornerRadius = 4;
//    @[@"已预约",@"学员签到",@"已完成",@"缺勤",@"未签到",@"等待确认",@"已完成",@"缺勤", @"已完成 - 未评价"]
    switch ([courseRecordModel gethcStatus]) {
        case 0:
        {
            self.lb4.textColor = RGBCOLOR(78, 149, 247);
            self.lb4.layer.borderColor= RGBCOLOR(78, 149, 247).CGColor;
            self.lb4.text = @" 已预约    ";
        }
            break;
        case 1:
        {
            self.lb4.textColor = RGBCOLOR(130, 188, 91);
            self.lb4.layer.borderColor= RGBCOLOR(130, 188, 91).CGColor;
            self.lb4.text = @" 学员签到    ";
        }
            break;
        case 2:
        case 6:
        case 8:
        {
            self.lb4.textColor = RGBCOLOR(78, 149, 247);
            self.lb4.layer.borderColor= RGBCOLOR(78, 149, 247).CGColor;
            self.lb4.text = @" 已完成   ";
        }
            break;
        case 3:
        case 7:
        {
            self.lb4.textColor = RGBCOLOR(236, 91, 85);
            self.lb4.layer.borderColor= RGBCOLOR(236, 91, 85).CGColor;
            self.lb4.text = @" 缺勤      ";
        }
            break;
        case 4:
        {
            self.lb4.textColor = RGBCOLOR(239, 134, 0);
            self.lb4.layer.borderColor= RGBCOLOR(239, 134, 0).CGColor;
            self.lb4.text = @" 未签到    ";
        }
            break;
        case 5:
        {
            self.lb4.textColor = RGBCOLOR(239, 134, 0);
            self.lb4.layer.borderColor= RGBCOLOR(239, 134, 0).CGColor;
            self.lb4.text = @" 等待确认     ";
        }
            break;
            
        default:
            break;
    }
}

@end
