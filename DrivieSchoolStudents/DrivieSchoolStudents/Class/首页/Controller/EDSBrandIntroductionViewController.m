//
//  EDSBrandIntroductionViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/26.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSBrandIntroductionViewController.h"

@interface EDSBrandIntroductionViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation EDSBrandIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"品牌介绍";
    self.webView.scalesPageToFit = YES;
    self.view.backgroundColor = WhiteColor;
    
    [self loadDocument:@"ppjs" inView:self.webView];
}

-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView{
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:@"docx"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

@end
