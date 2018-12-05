//
//  EDSUnCourseRecordViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/15.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSUnCourseRecordViewController.h"


#import "EDSCourseRecordModel.h"

@interface EDSUnCourseRecordViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *coachNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *coachSexLbl;
@property (weak, nonatomic) IBOutlet UILabel *ageSubjectLbl;
@property (weak, nonatomic) IBOutlet UILabel *schoolLbl;
@property (weak, nonatomic) IBOutlet UILabel *subjectNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *hoursLbl;

@end

@implementation EDSUnCourseRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"课程详情";
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.courseRecordModel.coachPhoto] placeholderImage:PLACEHOLDERGOODSIMAGE];
    self.coachNameLbl.text = self.courseRecordModel.coachName;
    self.coachSexLbl.text = self.courseRecordModel.coachSex;
    self.ageSubjectLbl.text = [NSString stringWithFormat:@"%@年执教 %@",self.courseRecordModel.teachAge,self.courseRecordModel.teachType];
    
    self.schoolLbl.text = self.courseRecordModel.schoolName;
    self.subjectNameLbl.text = self.courseRecordModel.subjectName;
    self.timeLbl.text = self.courseRecordModel.periodTime;
    self.hoursLbl.text = [NSString stringWithFormat:@"%@小时",self.courseRecordModel.hours];
}

- (void)setCourseRecordModel:(EDSCourseRecordModel *)courseRecordModel
{
    _courseRecordModel = courseRecordModel;
    
}

@end
