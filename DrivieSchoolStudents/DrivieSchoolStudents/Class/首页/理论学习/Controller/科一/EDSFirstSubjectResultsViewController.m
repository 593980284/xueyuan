//
//  EDSFirstSubjectResultsViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSFirstSubjectResultsViewController.h"

//#import "EDSFirsExamErrorsViewController.h"
//#import "EDSSubjectFourExamErrorsViewController.h"
#import "EDSEorrorsViewController.h"
#import "EDSSubjectFourErrorsViewController.h"

#import "EDSFirstSubjectExamFooterView.h"

@implementation EDSFirstSubjectExamResultModel

- (NSString *)time
{
    NSInteger second = 1000;
    
    if (_isFour) {
        second = 1800 - [_time integerValue];
    }else{
        second = 2700 - [_time integerValue];
    }
    
    NSInteger fen = second / 60;
    
    return [NSString stringWithFormat:@"用时%ld分%ld秒",(long)fen , second - fen*60];
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
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backClick) image:@"goback" highImage:@"goback"];
    
    self.timeLbl.text = self.resultModel.time;
    
    if (self.resultModel.isFour) {
        
        self.scorceLbl.text = [NSString stringWithFormat:@"%ld分",[self.resultModel.right integerValue]*2];
        self.descripLbl.text = [NSString stringWithFormat:@"做对%@道，做错%@道，%d道未做。",self.resultModel.right,self.resultModel.errors , (50 - [self.resultModel.right intValue] - [self.resultModel.errors intValue])];
    }else{
        
        self.scorceLbl.text = [NSString stringWithFormat:@"%@分",self.resultModel.right];
        self.descripLbl.text = [NSString stringWithFormat:@"做对%@道，做错%@道，%d道未做。",self.resultModel.right,self.resultModel.errors , (100 - [self.resultModel.right intValue] - [self.resultModel.errors intValue])];
    }
    
    [self.nextExamView bk_whenTapped:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    @weakify(self);
    [self.errorView bk_whenTapped:^{
        @strongify(self);
        if (self.resultModel.isFour) {
            
            EDSSubjectFourErrorsViewController *vc = [[EDSSubjectFourErrorsViewController alloc] init];
//            vc.errorsArr = self.errorsArr;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            EDSEorrorsViewController *vc = [[EDSEorrorsViewController alloc] init];
//            vc.errorsArr = self.errorsArr;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
    if (self.resultModel.isFour) {
        
        self.resultLbl.text = [self.resultModel.right integerValue]*2 >= 90 ? @"合格" : @"不合格";
    }else{
        
        self.resultLbl.text = [self.resultModel.right integerValue] >= 90 ? @"合格" : @"不合格";
    }
}

- (void)backClick
{
    UIViewController * viewVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 3];
    [self.navigationController popToViewController:viewVC animated:YES];
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
    
    if (self.resultModel.isFour) {
        
        NSAttributedString *attStr = [NSString attributedStringWithColorTitle:@"/50" normalTitle:@"" frontTitle:[NSString stringWithFormat:@"%ld",[self.resultModel.errors integerValue] + [self.resultModel.right integerValue]] diffentColor:ThirdColor];
        model.attar = attStr;
    }else{
        
        NSAttributedString *attStr = [NSString attributedStringWithColorTitle:@"/100" normalTitle:@"" frontTitle:[NSString stringWithFormat:@"%ld",[self.resultModel.errors integerValue] + [self.resultModel.right integerValue]] diffentColor:ThirdColor];
        model.attar = attStr;
    }
    
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
