//
//  EDSStudentDriverStrategyDetailViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/21.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentDriverStrategyDetailViewController.h"

@interface EDSStudentDriverStrategyDetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation EDSStudentDriverStrategyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"攻略详情";
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?studyStrategyId=%@&phone=%@",XCGL,self.studyStrategyId,[EDSSave account].phone]]]];
}

- (void)setStudyStrategyId:(NSString *)studyStrategyId
{
    _studyStrategyId = studyStrategyId;
}
@end
