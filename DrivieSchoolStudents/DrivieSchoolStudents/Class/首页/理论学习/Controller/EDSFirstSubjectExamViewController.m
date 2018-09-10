//
//  EDSFirstSubjectExamViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/10.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSFirstSubjectExamViewController.h"
#import "ZQCountDownView.h"

@interface EDSFirstSubjectExamViewController ()
/** 倒计时 */
@property (nonatomic, strong) ZQCountDownView  *countDownView;
@end

@implementation EDSFirstSubjectExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"考试";
    
    UIImageView *imageView = [UIImageView imageViewWithSuperView:self.view];
    imageView.image = [UIImage imageNamed:@"kscj_content_icon_time"];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    ZQCountDownView *countDownView = [[ZQCountDownView alloc] initWithFrame:CGRectMake(20, 6, 80, 20)];
    countDownView.themeColor = TableColor;
    countDownView.textColor = FirstColor;
    countDownView.textFont = kFont(14);
    [self.view addSubview:countDownView];
    countDownView.countDownTimeInterval = 2700;
    [countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imageView.mas_centerY);
        make.left.mas_equalTo(imageView.mas_right).mas_equalTo(8);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}


- (ZQCountDownView *)countDownView
{
    if (!_countDownView) {
        
    }
    return _countDownView;
}

@end
