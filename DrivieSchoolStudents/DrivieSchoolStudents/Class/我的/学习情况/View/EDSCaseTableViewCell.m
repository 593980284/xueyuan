//
//  EDSCaseTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/14.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCaseTableViewCell.h"
#import "EDSStudentExamResultInfoModel.h"

@interface EDSCaseTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *subjectLbl;
@property (weak, nonatomic) IBOutlet UILabel *resultLbl;
@property (weak, nonatomic) IBOutlet UILabel *souceLbl;
@property (weak, nonatomic) IBOutlet UILabel *examTypeLbl;

@end

@implementation EDSCaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setExamModel:(EDSStudentExamResultInfoModel *)examModel
{
    _examModel = examModel;
    
    self.subjectLbl.text = examModel.subType;
    self.resultLbl.text = examModel.examResult;
    self.souceLbl.text = examModel.examMarks;
    self.examTypeLbl.text = examModel.examType;
}

@end
