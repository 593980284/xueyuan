//
//  EDSSeeEvaluationViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/15.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSeeEvaluationViewController.h"

#import "EDSDriveStarView.h"

#import "EDSStudentEvaluationCoachRequest.h"

#import "EDSCourseRecordModel.h"
#import "EDSCommentDetailModel.h"

@interface EDSSeeEvaluationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *subjectLbl;
@property (weak, nonatomic) IBOutlet UILabel *sexLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet EDSDriveStarView *scorce1View;
@property (weak, nonatomic) IBOutlet EDSDriveStarView *scorce2View;
@property (weak, nonatomic) IBOutlet EDSDriveStarView *scorce3View;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;


@property (nonatomic, strong) EDSCommentDetailModel *commentDetailModel;

@end

@implementation EDSSeeEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评论详情";
    
    [self requestData];
    
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.courseRecordModel.coachPhoto] placeholderImage:PLACEHOLDERGOODSIMAGE];
    self.nameLbl.text = self.courseRecordModel.coachName;
    self.sexLbl.text = self.courseRecordModel.coachSex;
    self.subjectLbl.text = self.courseRecordModel.subjectName;
    self.timeLbl.text = self.courseRecordModel.periodTime;
    
}


- (void)requestData
{
    
    EDSStudentEvaluationCoachRequest *request = [EDSStudentEvaluationCoachRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            self.commentDetailModel = model;
            
            self.scorce1View.selectNumber = ceil([self.commentDetailModel.coachAbilityScore doubleValue] / 2);
            self.scorce2View.selectNumber = ceil([self.commentDetailModel.coachAttitudeScore doubleValue] / 2);
            self.scorce3View.selectNumber = ceil([self.commentDetailModel.coachHygieneScore doubleValue] / 2);
            
            NSArray *listArr = [self.commentDetailModel.coachLabel componentsSeparatedByString:@","];
            for (int i = 0; i < self.commentDetailModel.list.count; i ++) {
                
                if (i == 0) {
                    [self.button1 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button1 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                    if ([listArr containsObject:self.commentDetailModel.list[i].index]) {
                        
                        self.button1.selected = YES;
                        self.button1.layer.borderColor = ThemeColor.CGColor;
                    }
                    
                }else if (i == 1){
                    
                    [self.button2 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button2 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                    if ([listArr containsObject:self.commentDetailModel.list[i].index]) {
                        
                        self.button2.selected = YES;
                        self.button2.layer.borderColor = ThemeColor.CGColor;
                    }
                }else if (i == 2){
                    
                    [self.button3 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button3 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                    if ([listArr containsObject:self.commentDetailModel.list[i].index]) {
                        
                        self.button3.selected = YES;
                        self.button3.layer.borderColor = ThemeColor.CGColor;
                    }
                }else if (i == 3){
                    
                    [self.button4 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button4 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                    if ([listArr containsObject:self.commentDetailModel.list[i].index]) {
                        
                        self.button4.selected = YES;
                        self.button4.layer.borderColor = ThemeColor.CGColor;
                    }
                }else if (i == 4){
                    
                    [self.button5 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button5 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                    if ([listArr containsObject:self.commentDetailModel.list[i].index]) {
                        
                        self.button5.selected = YES;
                        self.button5.layer.borderColor = ThemeColor.CGColor;
                    }
                }else if (i == 5){
                    
                    [self.button6 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button6 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                    if ([listArr containsObject:self.commentDetailModel.list[i].index]) {
                        
                        self.button6.selected = YES;
                        self.button6.layer.borderColor = ThemeColor.CGColor;
                    }
                }
            }
            
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    request.courseRecordId = self.courseRecordModel.courseRecordId;
    request.showHUD = YES;
    [request  startRequest];
}

@end
