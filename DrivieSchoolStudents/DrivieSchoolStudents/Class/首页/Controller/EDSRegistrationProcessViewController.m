//
//  EDSRegistrationProcessViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/15.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSRegistrationProcessViewController.h"

@interface EDSRegistrationProcessViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation EDSRegistrationProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"报名流程";
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://111.39.245.156:8087/lexiang/dist/index.html#/signUp"]]];
}




@end
