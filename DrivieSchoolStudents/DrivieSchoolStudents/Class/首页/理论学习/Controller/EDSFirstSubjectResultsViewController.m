//
//  EDSFirstSubjectResultsViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSFirstSubjectResultsViewController.h"

#import "EDSFirstSubjectExamFooterView.h"

@interface EDSFirstSubjectResultsViewController ()

@property (strong, nonatomic) EDSFirstSubjectExamFooterView *footerView;

@end

@implementation EDSFirstSubjectResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"考试成绩";
    
    [self setFooterViewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setFooterViewModel
{
    EDSFirstSubjectExamFooterModel *model = [[EDSFirstSubjectExamFooterModel alloc] init];
    
    NSAttributedString *attStr = [NSString attributedStringWithColorTitle:@"/100" normalTitle:@"" frontTitle:@"10" diffentColor:ThirdColor];
    
    model.attar = attStr;
    model.correctstr = @"10";
    model.errorsstr = @"20";
    
    self.footerView.footerModel = model;
}

- (EDSFirstSubjectExamFooterView *)footerView
{
    if (!_footerView) {
        
        _footerView = [[EDSFirstSubjectExamFooterView alloc] init];
        [self.view addSubview:_footerView];
        [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(51);
        }];
    }
    return _footerView;
}
@end
