//
//  EDSCourseRecordCommentViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/31.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordCommentViewController.h"
#import "EDSCourseRecordViewController.h"

#import "EDSCommentStarsView.h"

#import <UITextView+Placeholder.h>

#import "EDSStudentEvaluationCoachRequest.h"
#import "EDSCommentSubmitReqest.h"

#import "EDSCourseRecordModel.h"
#import "EDSCommentDetailModel.h"


@interface EDSCourseRecordCommentViewController ()
{
    NSString *_coachAbilityScore;   //教练教学能力评分
    NSString *_coachAttitudeScore;  //教练服务态度评分
    NSString *_coachHygieneScore;   //教练车辆卫生评分
    NSMutableArray *_coachtagArr;          //被选的标签index， 英文逗号分割
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *subjectLbl;
@property (weak, nonatomic) IBOutlet UILabel *sexLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;


@property (weak, nonatomic) IBOutlet EDSCommentStarsView *driveStarView1;
@property (weak, nonatomic) IBOutlet EDSCommentStarsView *driveStarView2;
@property (weak, nonatomic) IBOutlet EDSCommentStarsView *driveStarView3;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *tagBgView;

@property (nonatomic, strong) EDSCommentDetailModel *commentDetailModel;

@end

@implementation EDSCourseRecordCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"课程记录";
    
    _coachAbilityScore = @"2";
    _coachAttitudeScore = @"2";
    _coachHygieneScore  = @"2";
    
    _coachtagArr = [[NSMutableArray alloc] init];
    
    [self setup];
    
    [self requestStudentEvaluationCoachRequestData];
}

- (void)requestStudentEvaluationCoachRequestData
{
    EDSStudentEvaluationCoachRequest *request = [EDSStudentEvaluationCoachRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            
            self.commentDetailModel = model;
            
            for (int i = 0; i < self.commentDetailModel.list.count; i ++) {
                
                if (i == 0) {
                    
                    [self.button1 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button1 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                }else if (i == 1){
                    
                    [self.button2 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button2 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                }else if (i == 2){
                    
                    [self.button3 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button3 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                }else if (i == 3){
                    
                    [self.button4 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button4 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                }else if (i == 4){
                    
                    [self.button5 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button5 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                }else if (i == 5){
                    
                    [self.button6 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button6 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                }
            }
        }
        
    } failureBlock:^(NSError *error) {
    
    }];
    request.courseRecordId = self.courseRecordModel.courseRecordId;
    request.showHUD = YES;
    [request  startRequest];
}

- (void)setCourseRecordModel:(EDSCourseRecordModel *)courseRecordModel
{
    _courseRecordModel = courseRecordModel; 
}

- (void)setup{
    
    self.scrollViewHeight.constant = CGRectGetMaxY(self.textView.frame);
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.courseRecordModel.coachPhoto] placeholderImage:PLACEHOLDERGOODSIMAGE];
    self.nameLbl.text = self.courseRecordModel.coachName;
    self.sexLbl.text = self.courseRecordModel.coachSex;
    self.subjectLbl.text = self.courseRecordModel.subjectName;
    self.timeLbl.text = self.courseRecordModel.periodTime;
    
    self.submitBtn.enabled = YES;
    self.submitBtn.backgroundColor = ThemeColor;
    
    @weakify(self);
    [self.submitBtn bk_whenTapped:^{
        @strongify(self);
        
        [self submitClick];
    }];
    
    self.driveStarView1.selectNumber = 1;
    self.driveStarView2.selectNumber = 1;
    self.driveStarView3.selectNumber = 1;
    
    self.driveStarView1.startBackNumber = ^(NSInteger selectNumber) {
        DLog(@"----------%ld",(long)selectNumber);
        self->_coachAbilityScore = [NSString stringWithFormat:@"%ld",selectNumber * 2];
    };
    self.driveStarView2.startBackNumber = ^(NSInteger selectNumber) {
        
        DLog(@"----------%ld",(long)selectNumber);
        self->_coachAttitudeScore = [NSString stringWithFormat:@"%ld",selectNumber * 2];
    };
    self.driveStarView3.startBackNumber = ^(NSInteger selectNumber) {
        
        DLog(@"----------%ld",(long)selectNumber);
        self->_coachHygieneScore = [NSString stringWithFormat:@"%ld",selectNumber * 2];
    };
    
    self.textView.layer.borderColor = [EDSToolClass getColorWithHexString:@"#CDCCCC"].CGColor;
    self.textView.layer.borderWidth = 1;
    self.textView.placeholder = @"请输入您对本节课的评价和想法";
    
    
    
    [self.button1 bk_whenTapped:^{
        @strongify(self);
        self.button1.selected = !self.button1.selected;
        self.button1.layer.borderColor = self.button1.selected ? ThemeColor.CGColor :SecondColor.CGColor;
        
        if (self.button1.selected) {
            
            [self->_coachtagArr addObject: self.commentDetailModel.list[0].index];
        }else{
            
            [self->_coachtagArr removeObject:self.commentDetailModel.list[0].index];
        }
    }];
    [self.button2 bk_whenTapped:^{
        @strongify(self);
        self.button2.selected = !self.button2.selected;
        self.button2.layer.borderColor = self.button2.selected ? ThemeColor.CGColor :SecondColor.CGColor;
        
        if (self.button2.selected) {
            
            [self->_coachtagArr addObject: self.commentDetailModel.list[1].index];
        }else{
            
            [self->_coachtagArr removeObject:self.commentDetailModel.list[1].index];
        }
    }];
    [self.button3 bk_whenTapped:^{
        @strongify(self);
        self.button3.selected = !self.button3.selected;
        self.button3.layer.borderColor = self.button3.selected ? ThemeColor.CGColor :SecondColor.CGColor;
//        [self setSubmitBtnStauts];
        if (self.button3.selected) {
            
            [self->_coachtagArr addObject: self.commentDetailModel.list[2].index];
        }else{
            
            [self->_coachtagArr removeObject:self.commentDetailModel.list[2].index];
        }
    }];
    [self.button4 bk_whenTapped:^{
        @strongify(self);
        self.button4.selected = !self.button4.selected;
        self.button4.layer.borderColor = self.button4.selected ? ThemeColor.CGColor :SecondColor.CGColor;
//        [self setSubmitBtnStauts];
        if (self.button4.selected) {
            
            [self->_coachtagArr addObject: self.commentDetailModel.list[3].index];
        }else{
            
            [self->_coachtagArr removeObject:self.commentDetailModel.list[3].index];
        }
    }];
    [self.button5 bk_whenTapped:^{
        @strongify(self);
        self.button5.selected = !self.button5.selected;
        self.button5.layer.borderColor = self.button5.selected ? ThemeColor.CGColor :SecondColor.CGColor;
//        [self setSubmitBtnStauts];
        if (self.button5.selected) {
            
            [self->_coachtagArr addObject: self.commentDetailModel.list[4].index];
        }else{
            
            [self->_coachtagArr removeObject:self.commentDetailModel.list[4].index];
        }
    }];
    [self.button6 bk_whenTapped:^{
        @strongify(self);
        self.button6.selected = !self.button6.selected;
        self.button6.layer.borderColor = self.button6.selected ? ThemeColor.CGColor :SecondColor.CGColor;
//        [self setSubmitBtnStauts];
        if (self.button6.selected) {
            
            [self->_coachtagArr addObject: self.commentDetailModel.list[5].index];
        }else{
            
            [self->_coachtagArr removeObject:self.commentDetailModel.list[5].index];
        }
    }];
}

- (void)submitClick
{
    EDSCommentSubmitReqest *request = [EDSCommentSubmitReqest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[EDSCourseRecordViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }
    } failureBlock:^(NSError *error) {
    
    }];
    request.courseRecordId = self.courseRecordModel.courseRecordId;
    request.coachAbilityScore = _coachAbilityScore;
    request.coachAttitudeScore = _coachAttitudeScore;
    request.coachHygieneScore = _coachHygieneScore;
    request.coachLabel = [_coachtagArr componentsJoinedByString:@","];//,为分隔符;
    request.coachEvaluationContent = self.textView.text.length > 0 ? self.textView.text : @"";
    request.showHUD = YES;
    [request startRequest];
}

- (void)setSubmitBtnStauts
{
    if (self.button1.selected | self.button2.selected | self.button3.selected | self.button4.selected | self.button5.selected | self.button6.selected) {
        
        self.submitBtn.enabled = YES;
        self.submitBtn.backgroundColor = ThemeColor;
    }else{
        self.submitBtn.enabled = NO;
        self.submitBtn.backgroundColor = [EDSToolClass getColorWithHexString:@"#BBBBBB"];
    }
}
@end
