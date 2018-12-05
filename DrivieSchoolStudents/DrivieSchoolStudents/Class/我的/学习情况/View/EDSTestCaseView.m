//
//  EDSTestCaseView.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/13.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSTestCaseView.h"
#import "EDSStudentTrainningSummaryModel.h"

#import "EDSStudentTrainningSummarmRequest.h"

@interface EDSTestCaseView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *sub1UsedHoursLbl;//课堂学时
@property (weak, nonatomic) IBOutlet UILabel *sub1UsedNeteduLbl;//远程学时
@property (weak, nonatomic) IBOutlet UILabel *sub1SurplusHoursLbl;//剩余学时

@property (weak, nonatomic) IBOutlet UILabel *sub2UsedHoursLbl;//实车学时
@property (weak, nonatomic) IBOutlet UILabel *sub2UsedImitateLbl;//模拟学时
@property (weak, nonatomic) IBOutlet UILabel *sub2SurplusHoursLbl;//剩余学时
@property (weak, nonatomic) IBOutlet UILabel *sub2NonrecognitionhoursLbl;//无效学时
@property (weak, nonatomic) IBOutlet UILabel *sub2UsedDistenceLbl;//已学里程
@property (weak, nonatomic) IBOutlet UILabel *sub2SurplusDistenceLbl;//剩余里程
@property (weak, nonatomic) IBOutlet UILabel *sub2NonrecognitiondistenceLbl;//无效里程

@property (weak, nonatomic) IBOutlet UILabel *sub3UsedHoursLbl;//实车学时
@property (weak, nonatomic) IBOutlet UILabel *sub3UsedImitateLbl;//模拟学时
@property (weak, nonatomic) IBOutlet UILabel *sub3SurplusHoursLbl;//剩余学时
@property (weak, nonatomic) IBOutlet UILabel *sub3NonrecognitionhoursLbl;//无效学时
@property (weak, nonatomic) IBOutlet UILabel *sub3UsedDistenceLbl;//已学里程
@property (weak, nonatomic) IBOutlet UILabel *sub3SurplusDistenceLbl;//剩余里程
@property (weak, nonatomic) IBOutlet UILabel *sub3NonrecognitiondistenceLbl;//无效里程

@property (weak, nonatomic) IBOutlet UILabel *sub4UsedHoursLbl;//课堂学时
@property (weak, nonatomic) IBOutlet UILabel *sub4UsedNeteduLbl;//远程学时
@property (weak, nonatomic) IBOutlet UILabel *sub4SurplusHoursLb;//剩余学时

@end

@implementation EDSTestCaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSTestCaseView" owner:self options:nil] lastObject];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSTestCaseView" owner:self options:nil] lastObject];
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    EDSStudentTrainningSummarmRequest *request = [EDSStudentTrainningSummarmRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        if (errCode == 1) {
            EDSStudentTrainningSummaryModel *dict = model;
            
            self.sub1UsedHoursLbl.text = dict.sub1UsedHours;
            self.sub1UsedNeteduLbl.text = dict.sub1UsedNetedu;
            self.sub1SurplusHoursLbl.text = dict.sub1SurplusHours;
            
            self.sub2UsedHoursLbl.text = dict.sub2UsedHours;
            self.sub2UsedImitateLbl.text = dict.sub2UsedImitate;
            self.sub2SurplusHoursLbl.text = dict.sub2SurplusHours;
            self.sub2NonrecognitionhoursLbl.text = dict.sub2Nonrecognitionhours;
            self.sub2UsedDistenceLbl.text = dict.sub2UsedDistence;
            self.sub2SurplusDistenceLbl.text = dict.sub2SurplusDistence;
            self.sub2NonrecognitiondistenceLbl.text = dict.sub2Nonrecognitiondistence;
            
            self.sub3UsedHoursLbl.text = dict.sub3UsedHours;
            self.sub3UsedImitateLbl.text = dict.sub3UsedImitate;
            self.sub3SurplusHoursLbl.text = dict.sub3SurplusHours;
            self.sub3NonrecognitionhoursLbl.text = dict.sub3Nonrecognitionhours;
            self.sub3UsedDistenceLbl.text = dict.sub3UsedDistence;
            self.sub3SurplusDistenceLbl.text = dict.sub3SurplusDistence;
            self.sub3NonrecognitiondistenceLbl.text = dict.sub3Nonrecognitiondistence;
            
            self.sub4UsedHoursLbl.text = dict.sub4UsedHours;
            self.sub4UsedNeteduLbl.text = dict.sub4UsedNetedu;
            self.sub4SurplusHoursLb.text = dict.sub4SurplusHours;
        }
    } failureBlock:^(NSError *error) {
    
    }];
    request.phone = [EDSSave account].phone;
    request.showHUD = YES;
    [request startRequest];
}

@end
