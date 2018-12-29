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
#import "LEEStarRating.h";

static const NSInteger MAX_LIMIT_NUMS = 500;

@interface EDSCourseRecordCommentViewController ()<UITextViewDelegate>
{
    NSString *_coachAbilityScore;   //教练教学能力评分
    NSString *_coachAttitudeScore;  //教练服务态度评分
    NSString *_coachHygieneScore;   //教练车辆卫生评分
    NSMutableArray *_coachtagArr;          //被选的标签index， 英文逗号分割
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *logo1;
@property (weak, nonatomic) IBOutlet UIImageView *logo2;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
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
@property (nonatomic, strong)LEEStarRating *starView;

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
    self.view.backgroundColor = [EDSToolClass getColorWithHexString:@"f4f4f4" alpha:1];
    _scrollView.layer.cornerRadius = 5;
    _scrollView.clipsToBounds = YES;
    [self requestStudentEvaluationCoachRequestData];
    self.view.userInteractionEnabled = self.isCanEdit;
    self.submitBtn.hidden = YES;
}

- (void)requestStudentEvaluationCoachRequestData
{
    EDSStudentEvaluationCoachRequest *request = [EDSStudentEvaluationCoachRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            
            self.commentDetailModel = model;
            if (self.isCanEdit == NO) {
                self.driveStarView1.selectNumber = ceil([self.commentDetailModel.coachAbilityScore doubleValue] / 2);
                self.driveStarView2.selectNumber = ceil([self.commentDetailModel.coachAttitudeScore doubleValue] / 2);
                self.driveStarView3.selectNumber = ceil([self.commentDetailModel.coachHygieneScore doubleValue] / 2);
            }
            NSArray *listArr = [self.commentDetailModel.coachLabel componentsSeparatedByString:@","];
            self.textView.text = self.commentDetailModel.coachEvaluationContent;
            for (int i = 0; i < self.commentDetailModel.list.count; i ++) {
                
                if (i == 0) {
                    
                    [self.button1 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button1 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                    if ([listArr containsObject:self.commentDetailModel.list[i].index]) {
                        
                        self.button1.selected = YES;
                        self.button1.layer.borderColor = YellowColor.CGColor;
                    }
                }else if (i == 1){
                    
                    [self.button2 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button2 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                    if ([listArr containsObject:self.commentDetailModel.list[i].index]) {
                        
                        self.button2.selected = YES;
                        self.button2.layer.borderColor = YellowColor.CGColor;
                    }
                }else if (i == 2){
                    
                    [self.button3 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button3 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                    if ([listArr containsObject:self.commentDetailModel.list[i].index]) {
                        
                        self.button3.selected = YES;
                        self.button3.layer.borderColor = YellowColor.CGColor;
                    }
                }else if (i == 3){
                    
                    [self.button4 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button4 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                    if ([listArr containsObject:self.commentDetailModel.list[i].index]) {
                        
                        self.button4.selected = YES;
                        self.button4.layer.borderColor = YellowColor.CGColor;
                    }
                }else if (i == 4){
                    
                    [self.button5 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button5 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                    if ([listArr containsObject:self.commentDetailModel.list[i].index]) {
                        
                        self.button5.selected = YES;
                        self.button5.layer.borderColor = YellowColor.CGColor;
                    }
                }else if (i == 5){
                    
                    [self.button6 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateNormal];
                    [self.button6 setTitle:self.commentDetailModel.list[i].labelName forState:UIControlStateSelected];
                    if ([listArr containsObject:self.commentDetailModel.list[i].index]) {
                        
                        self.button6.selected = YES;
                        self.button6.layer.borderColor = YellowColor.CGColor;
                    }
                }
            }
        }
        
    } failureBlock:^(NSError *error) {
    
    }];
    request.courseRecordId = self.courseRecordModel.courseRecordId;
    [request  startRequest];
}

- (void)setCourseRecordModel:(EDSCourseRecordModel *)courseRecordModel
{
    _courseRecordModel = courseRecordModel; 
}

- (void)setup{
    
    self.scrollViewHeight.constant = CGRectGetMaxY(self.textView.frame) + 20;
    
    _starView = [[LEEStarRating alloc]initWithFrame:CGRectMake(0, 0, 80, 1) Count:5];
    _starView.maximumScore = 5;
    _starView.type = RatingTypeHalf;
    _starView.checkedImage = [UIImage imageNamed:@"star_content_icon_selected"];
    _starView.uncheckedImage = [UIImage imageNamed:@"star_content_icon_default"];
    
    self.sexImage.image = [UIImage imageNamed:[self.courseRecordModel.coachSex isEqualToString:@"男"]?@"ic-man":@"ic-woman"];
    //    self.numberRemainingLbl.text = model.showNoAppointmentNum;
    NSArray *logs = [self.courseRecordModel.identity componentsSeparatedByString:@","];
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
    [self.scrollView addSubview:_starView];
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(8);
        make.width.mas_equalTo(110);
        make.right.mas_equalTo(self.scrollView.mas_right).offset(-17.5);
    }];
    _starView.currentScore = self.courseRecordModel.coachStar/2.0;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.courseRecordModel.coachPhoto] placeholderImage:PLACEHOLDERGOODSIMAGE];
    self.nameLbl.text = self.courseRecordModel.coachName;
 
    self.timeLbl.text = self.courseRecordModel.showSubjectAge;
    
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
//    self.textView.layer.borderWidth = 1;
    self.textView.placeholder = @"请输入您对本节课的评价和想法";
    self.textView.delegate = self;
    self.textView.layer.cornerRadius = 4;
    self.textView.clipsToBounds = YES;
    
    
    
    [self.button1 bk_whenTapped:^{
        @strongify(self);
        self.button1.selected = !self.button1.selected;
        self.button1.layer.borderColor = self.button1.selected ? YellowColor.CGColor :SecondColor.CGColor;
        
        if (self.button1.selected) {
            
            [self->_coachtagArr addObject: self.commentDetailModel.list[0].index];
        }else{
            
            [self->_coachtagArr removeObject:self.commentDetailModel.list[0].index];
        }
    }];
    [self.button2 bk_whenTapped:^{
        @strongify(self);
        self.button2.selected = !self.button2.selected;
        self.button2.layer.borderColor = self.button2.selected ? YellowColor.CGColor :SecondColor.CGColor;
        
        if (self.button2.selected) {
            
            [self->_coachtagArr addObject: self.commentDetailModel.list[1].index];
        }else{
            
            [self->_coachtagArr removeObject:self.commentDetailModel.list[1].index];
        }
    }];
    [self.button3 bk_whenTapped:^{
        @strongify(self);
        self.button3.selected = !self.button3.selected;
        self.button3.layer.borderColor = self.button3.selected ? YellowColor.CGColor :SecondColor.CGColor;
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
        self.button4.layer.borderColor = self.button4.selected ? YellowColor.CGColor :SecondColor.CGColor;
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
        self.button5.layer.borderColor = self.button5.selected ? YellowColor.CGColor :SecondColor.CGColor;
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
        self.button6.layer.borderColor = self.button6.selected ? YellowColor.CGColor :SecondColor.CGColor;
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
        self.submitBtn.backgroundColor = YellowColor;
    }else{
        self.submitBtn.enabled = NO;
        self.submitBtn.backgroundColor = [EDSToolClass getColorWithHexString:@"#BBBBBB"];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}
- (void)textViewDidChange:(UITextView *)textView
{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
    }
    
    //不让显示负数
    //    self.lbNums.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,MAX_LIMIT_NUMS - existTextNum),MAX_LIMIT_NUMS];
}
@end
