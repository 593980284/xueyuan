//
//  EDSOnlineAboutTestViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineAboutTestViewController.h"

@interface EDSOnlineAboutTestViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation EDSOnlineAboutTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"在线约考";
    
    if ([[EDSSave account].bookingExamUrl rangeOfString:@"http"].location != NSNotFound) {
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[EDSSave account].bookingExamUrl]]];
    }else{
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",[EDSSave account].bookingExamUrl]]]];
    }
}

@end
