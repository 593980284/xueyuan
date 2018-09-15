//
//  EDSFirstSubjectResultsViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSFirstSubjectResultsViewController.h"

#import "EDSFirsExamErrorsViewController.h"

#import "EDSFirstSubjectExamFooterView.h"

@implementation EDSFirstSubjectExamResultModel

- (NSString *)time
{
    NSInteger second = 2700 - [_time integerValue];
    
    NSInteger fen = second / 60;
    
    return [NSString stringWithFormat:@"用时%ld分%d秒",(long)fen , second - fen];
}

@end

@interface EDSFirstSubjectResultsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *scorceLbl;
@property (weak, nonatomic) IBOutlet UILabel *descripLbl;
@property (weak, nonatomic) IBOutlet UIView *nextExamView;
@property (weak, nonatomic) IBOutlet UILabel *resultLbl;
@property (weak, nonatomic) IBOutlet UIView *errorView;

@property (strong, nonatomic) EDSFirstSubjectExamFooterView *footerView;

@end

@implementation EDSFirstSubjectResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"考试成绩";
    
    [self setFooterViewModel];
    
    self.timeLbl.text = self.resultModel.time;
    self.scorceLbl.text = [NSString stringWithFormat:@"%@分",self.resultModel.right];
    self.descripLbl.text = [NSString stringWithFormat:@"做对%@道，做错%@道，%d道未做。",self.resultModel.right,self.resultModel.errors , (100 - [self.resultModel.right intValue] - [self.resultModel.errors intValue])];
    
    [self.nextExamView bk_whenTapped:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    @weakify(self);
    [self.errorView bk_whenTapped:^{
        @strongify(self);
        EDSFirsExamErrorsViewController *vc = [[EDSFirsExamErrorsViewController alloc] init];
        vc.errorsArr = self.errorsArr;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    self.resultLbl.text = [self.resultModel.right integerValue] >= 90 ? @"合格" : @"不合格";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setResultModel:(EDSFirstSubjectExamResultModel *)resultModel
{
    _resultModel = resultModel;
    
}


- (void)setFooterViewModel
{
    EDSFirstSubjectExamFooterModel *model = [[EDSFirstSubjectExamFooterModel alloc] init];
    
    NSAttributedString *attStr = [NSString attributedStringWithColorTitle:@"/100" normalTitle:@"" frontTitle:self.resultModel.right diffentColor:ThirdColor];
    
    model.attar = attStr;
    model.correctstr = self.resultModel.right;
    model.errorsstr = self.resultModel.errors;
    
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
