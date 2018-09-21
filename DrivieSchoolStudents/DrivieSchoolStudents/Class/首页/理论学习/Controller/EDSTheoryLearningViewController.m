//
//  EDSTheoryLearningViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSTheoryLearningViewController.h"
#import "EDSPracticeViewController.h"//联系
#import "EDSCollectionViewController.h"//收藏
#import "EDSEorrorsViewController.h"//错题
#import "EDSRecitedPoliticsViewController.h"//背题
#import "EDSFirstSubjectExamViewController.h"//科目一考试


//科四
#import "EDSSubjectFourPracticeViewController.h"//练习
#import "EDSSubjectFourCollectionViewController.h"//收藏
#import "EDSSubjectFourErrorsViewController.h"//错题
#import "EDSSubjectFourRecitedPoliticsViewController.h"//背题
#import "EDSSubjectFourExamViewController.h"//考试

#import "EDSTheoryLearningHeaderView.h"
#import "EDSTheoryLearningSubjectOneView.h"
#import "EDSSubjectTwoView.h"
#import "EDSSubjectThreeView.h"

@interface EDSTheoryLearningViewController ()

/** 科目一 */
@property (nonatomic, strong) EDSTheoryLearningSubjectOneView  *subjectOneView;
/** 科目二 */
@property (nonatomic, strong) EDSSubjectTwoView  *subjectTwoView;
/** 科目三 */
@property (nonatomic, strong) EDSSubjectThreeView  *subjectThreeView;
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
            self.subjectTwoView.subjectLoad = @"";
        }else if ([string isEqualToString:@"科目三"]){
            
            self.subjectThreeView.hidden = NO;
            self.subjectThreeView.subjectLoad = @"";
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
        EDSFirstSubjectExamViewController *vc = [[EDSFirstSubjectExamViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.subjectOneView.speakTextBgView bk_whenTapped:^{
        DLog(@"背题");
        EDSRecitedPoliticsViewController *vc = [[EDSRecitedPoliticsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.subjectOneView.collectBgView bk_whenTapped:^{
        DLog(@"收藏");
        EDSCollectionViewController *vc = [[EDSCollectionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.subjectOneView.mistakesBgView bk_whenTapped:^{
        DLog(@"错题");
        EDSEorrorsViewController *vc = [[EDSEorrorsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    
    [self.subjectFourView.practiceBgView bk_whenTapped:^{
       
        EDSSubjectFourPracticeViewController *vc = [[EDSSubjectFourPracticeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.subjectFourView.collectBgView bk_whenTapped:^{
        
        EDSSubjectFourCollectionViewController *vc = [[EDSSubjectFourCollectionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.subjectFourView.mistakesBgView bk_whenTapped:^{
       
        EDSSubjectFourErrorsViewController *vc = [[EDSSubjectFourErrorsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.subjectFourView.speakTextBgView bk_whenTapped:^{
        
        EDSSubjectFourRecitedPoliticsViewController *vc = [[EDSSubjectFourRecitedPoliticsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.subjectFourView.examBgView bk_whenTapped:^{
        
        EDSSubjectFourExamViewController *vc = [[EDSSubjectFourExamViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
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

- (EDSSubjectTwoView *)subjectTwoView
{
    if (!_subjectTwoView) {
        
        _subjectTwoView = [[EDSSubjectTwoView alloc] init];
        [self.view addSubview:_subjectTwoView];
        [_subjectTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(45);
        }];
        
    }
    return _subjectTwoView;
}

- (EDSSubjectThreeView *)subjectThreeView
{
    if (!_subjectThreeView) {
        
        _subjectThreeView = [[EDSSubjectThreeView alloc] init];
        [self.view addSubview:_subjectThreeView];
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
