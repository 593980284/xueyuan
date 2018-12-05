//
//  EDSElegantDemeanourViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/21.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSElegantDemeanourViewController.h"

@interface EDSElegantDemeanourViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation EDSElegantDemeanourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"风采详情";
    DLog(@"%@",[NSString stringWithFormat:@"%@?id=%@&phone=%@",JXFC,self.schoolId,[EDSSave account].phone]);
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?id=%@&phone=%@",JXFC,self.schoolId,[EDSSave account].phone]]]];
}

- (void)setSchoolId:(NSString *)schoolId
{
    _schoolId = schoolId;
}

@end
