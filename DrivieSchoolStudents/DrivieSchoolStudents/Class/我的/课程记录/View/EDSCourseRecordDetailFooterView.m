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
    self.periodTimeLbl.text = courseRecordModel.periodTime;
    self.hoursLbl.text = [NSString stringWithFormat:@"%@小时",courseRecordModel.hours];
    self.reachStuNumLbl.text = courseRecordModel.reachStuNum;
    self.noReachStuNumLbl.text = courseRecordModel.noReachStuNum;
}

@end
