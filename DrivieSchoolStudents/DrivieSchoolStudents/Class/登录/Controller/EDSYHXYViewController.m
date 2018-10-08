//
//  EDSYHXYViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/10/8.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSYHXYViewController.h"

@interface EDSYHXYViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@end

@implementation EDSYHXYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = WhiteColor;
    ///调用
    [self loadDocument:@"yhxy.docx" inView:self.webView];
    [self.view addSubview:self.webView];
    
    ///自动适应大小
    self.webView.scalesPageToFit = YES;
    
    [self.view bringSubviewToFront:self.closeBtn];
}

-(void)loadDocument:(NSString *)documentName inView:(UIWebView *)webView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

- (IBAction)closeBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
