//
//  EDSCourseRecordCommentViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/31.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordCommentViewController.h"

#import "EDSDriveStarView.h"

#import <UITextView+Placeholder.h>

@interface EDSCourseRecordCommentViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;

@property (weak, nonatomic) IBOutlet EDSDriveStarView *driveStarView1;
@property (weak, nonatomic) IBOutlet EDSDriveStarView *driveStarView2;
@property (weak, nonatomic) IBOutlet EDSDriveStarView *driveStarView3;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *tagBgView;

@end

@implementation EDSCourseRecordCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"课程记录";
    
    [self setup];
}

- (void)setup{
    
    self.scrollViewHeight.constant = CGRectGetMaxY(self.textView.frame);
    
//    self.scrollViewHeight.constant = CGRectGetMaxY(self.tagBgView.frame);
    
    self.submitBtn.backgroundColor = [EDSToolClass getColorWithHexString:@"#BBBBBB"];
    self.submitBtn.enabled = NO;
    [self.submitBtn bk_whenTapped:^{
        DLog(@"11111111");
    }];
    
    self.driveStarView1.isChooes = YES;
    self.driveStarView1.selectNumber = 1;
    self.driveStarView2.isChooes = YES;
    self.driveStarView2.selectNumber = 1;
    self.driveStarView3.isChooes = YES;
    self.driveStarView3.selectNumber = 1;
    
    @weakify(self);
    self.driveStarView1.startBackNumber = ^(NSInteger selectNumber) {
        DLog(@"----------%ld",(long)selectNumber);
    };
    self.driveStarView2.startBackNumber = ^(NSInteger selectNumber) {
        
        DLog(@"----------%ld",(long)selectNumber);
    };
    self.driveStarView3.startBackNumber = ^(NSInteger selectNumber) {
        
        DLog(@"----------%ld",(long)selectNumber);
    };
    
    self.textView.layer.borderColor = [EDSToolClass getColorWithHexString:@"#CDCCCC"].CGColor;
    self.textView.layer.borderWidth = 1;
    self.textView.placeholder = @"请输入您对本节课的评价和想法";
    
    [self.button1 bk_whenTapped:^{
        @strongify(self);
        self.button1.selected = !self.button1.selected;
        self.button1.layer.borderColor = self.button1.selected ? ThemeColor.CGColor :SecondColor.CGColor;
        [self setSubmitBtnStauts];
    }];
    [self.button2 bk_whenTapped:^{
        @strongify(self);
        self.button2.selected = !self.button2.selected;
        self.button2.layer.borderColor = self.button2.selected ? ThemeColor.CGColor :SecondColor.CGColor;
        [self setSubmitBtnStauts];
    }];
    [self.button3 bk_whenTapped:^{
        @strongify(self);
        self.button3.selected = !self.button3.selected;
        self.button3.layer.borderColor = self.button3.selected ? ThemeColor.CGColor :SecondColor.CGColor;
        [self setSubmitBtnStauts];
    }];
    [self.button4 bk_whenTapped:^{
        @strongify(self);
        self.button4.selected = !self.button4.selected;
        self.button4.layer.borderColor = self.button4.selected ? ThemeColor.CGColor :SecondColor.CGColor;
        [self setSubmitBtnStauts];
    }];
    [self.button5 bk_whenTapped:^{
        @strongify(self);
        self.button5.selected = !self.button5.selected;
        self.button5.layer.borderColor = self.button5.selected ? ThemeColor.CGColor :SecondColor.CGColor;
        [self setSubmitBtnStauts];
    }];
    [self.button6 bk_whenTapped:^{
        @strongify(self);
        self.button6.selected = !self.button6.selected;
        self.button6.layer.borderColor = self.button6.selected ? ThemeColor.CGColor :SecondColor.CGColor;
        [self setSubmitBtnStauts];
    }];
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
