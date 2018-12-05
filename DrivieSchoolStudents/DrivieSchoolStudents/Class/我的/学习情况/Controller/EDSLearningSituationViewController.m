//
//  EDSLearningSituationViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSLearningSituationViewController.h"

#import "EDSHeaderPageButtonView.h"
#import "EDSTestCaseView.h"
#import "EDSCaseBgView.h"

@interface EDSLearningSituationViewController ()

@property (nonatomic ,strong) EDSTestCaseView *learningSituationView;
@property (nonatomic ,strong) EDSCaseBgView *caseBgView;

@end

@implementation EDSLearningSituationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"学习";
    
    EDSHeaderPageButtonView *headerView = [[EDSHeaderPageButtonView alloc] init];
    headerView.btnArr = @[@"学习情况",@"考试情况"];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    
    _learningSituationView = [[EDSTestCaseView alloc] init];
    [self.view addSubview:_learningSituationView];
    [_learningSituationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(45);
    }];
    
    _caseBgView = [[EDSCaseBgView alloc] init];
    [self.view addSubview:_caseBgView];
    [_caseBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(45);
    }];
    
    _learningSituationView.hidden = NO;
    _caseBgView.hidden = YES;
    
    headerView.headerPageButtonDidSelectStringback = ^(NSString *titleStr) {
        
        if ([titleStr isEqualToString:@"学习情况"]) {
            
            self->_learningSituationView.hidden = NO;
            self->_caseBgView.hidden = YES;
            
        }else{
            
            self->_learningSituationView.hidden = YES;
            self->_caseBgView.hidden = NO;
        }
    };
    
}





@end
