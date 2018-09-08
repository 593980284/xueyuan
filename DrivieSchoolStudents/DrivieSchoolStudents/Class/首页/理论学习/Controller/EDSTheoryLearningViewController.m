//
//  EDSTheoryLearningViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSTheoryLearningViewController.h"
#import "EDSPracticeViewController.h"

#import "EDSTheoryLearningHeaderView.h"
#import "EDSTheoryLearningSubjectOneView.h"

@interface EDSTheoryLearningViewController ()

/** 科目一 */
@property (nonatomic, strong) EDSTheoryLearningSubjectOneView  *subjectOneView;
/** 科目二 */
@property (nonatomic, strong) UIView  *subjectTwoView;
/** 科目三 */
@property (nonatomic, strong) UIView  *subjectThreeView;
/** 科目四 */
@property (nonatomic, strong) EDSTheoryLearningSubjectOneView  *subjectFourView;

@end

@implementation EDSTheoryLearningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"理论学习";
    
    EDSTheoryLearningHeaderView *headerView = [[EDSTheoryLearningHeaderView alloc] init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    @weakify(self);
    headerView.headerDidSelectBtn = ^(NSString *string) {
        @strongify(self);
        
        self.subjectOneView.hidden = YES;
        self.subjectTwoView.hidden = YES;
        self.subjectThreeView.hidden = YES;
        self.subjectFourView.hidden = YES;
        if ([string isEqualToString:@"科目一"]) {
            
            self.subjectOneView.hidden = NO;
        }else if ([string isEqualToString:@"科目二"]){
            
            self.subjectTwoView.hidden = NO;
        }else if ([string isEqualToString:@"科目三"]){
            
            self.subjectThreeView.hidden = NO;
        }else{
            
            self.subjectFourView.hidden = NO;
        }
    };
    
    self.subjectOneView.hidden = NO;
    self.subjectTwoView.hidden = YES;
    self.subjectThreeView.hidden = YES;
    self.subjectFourView.hidden = YES;
    [self.subjectOneView.practiceBgView  bk_whenTapped:^{
        DLog(@"练习");
        EDSPracticeViewController *vc = [[EDSPracticeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.subjectOneView.examBgView bk_whenTapped:^{
        DLog(@"考试");
    }];
    
    [self.subjectOneView.speakTextBgView bk_whenTapped:^{
        DLog(@"背题");
    }];
    
    [self.subjectOneView.collectBgView bk_whenTapped:^{
        DLog(@"收藏");
    }];
    
    [self.subjectOneView.mistakesBgView bk_whenTapped:^{
        DLog(@"错题");
    }];
}


#pragma mark ------------------------ 懒加载 --------------------------------
- (EDSTheoryLearningSubjectOneView *)subjectOneView
{
    if (!_subjectOneView) {
        
        _subjectOneView = [[EDSTheoryLearningSubjectOneView alloc] init];
        [self.view addSubview:_subjectOneView];
        [_subjectOneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(45);
        }];
    }
    return _subjectOneView;
}

- (UIView *)subjectTwoView
{
    if (!_subjectTwoView) {
        
        _subjectTwoView = [UIView viewWithBackgroundColor:ThemeColor superView:self.view];
        [_subjectTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(45);
        }];
    }
    return _subjectTwoView;
}

- (UIView *)subjectThreeView
{
    if (!_subjectThreeView) {
        
        _subjectThreeView = [UIView viewWithBackgroundColor:ThemeColor superView:self.view];
        [_subjectThreeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(45);
        }];
    }
    return _subjectThreeView;
}

- (EDSTheoryLearningSubjectOneView *)subjectFourView
{
    if (!_subjectFourView) {
        
        _subjectFourView = [[EDSTheoryLearningSubjectOneView alloc] init];
        [self.view addSubview:_subjectFourView];
        [_subjectFourView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(45);
        }];
    }
    return _subjectFourView;
}
@end
