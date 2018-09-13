//
//  EDSCourseRecordDetailHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/31.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordDetailHeaderView.h"

#import "EDSDriveStarView.h"
#import "EDSCourseRecordModel.h"

@interface EDSCourseRecordDetailHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *coursNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *coursSexLbl;
@property (weak, nonatomic) IBOutlet UILabel *ageSubjectLbl;
@property (weak, nonatomic) IBOutlet EDSDriveStarView *coachScoreView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLbl;

@end

@implementation EDSCourseRecordDetailHeaderView

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSCourseRecordDetailHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}

- (void)setCourseRecordModel:(EDSCourseRecordModel *)courseRecordModel
{
    _courseRecordModel = courseRecordModel;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:courseRecordModel.coachPhoto] placeholderImage:PLACEHOLDERGOODSIMAGE];
    self.coursNameLbl.text = courseRecordModel.coachName;
    self.coursSexLbl.text = courseRecordModel.coachSex;
    self.ageSubjectLbl.text = [NSString stringWithFormat:@"%@年执教 %@",courseRecordModel.teachAge,courseRecordModel.subjectName];
    self.coachScoreView.selectNumber = ceil([courseRecordModel.coachScore doubleValue]/2);
    self.scoreLbl.text = [NSString stringWithFormat:@"%@分",courseRecordModel.coachScore];
}
@end
