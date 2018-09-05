//
//  EDSBrandIntroductionViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/5.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSBrandIntroductionViewController.h"

@interface EDSBrandIntroductionViewController ()

@end

@implementation EDSBrandIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"品牌介绍" ofType:@"docx"];
    NSURL *url = [NSURL fileURLWithPath:path];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    self.webView.scrollView.scrollEnabled = YES;

//    self.webView load
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
