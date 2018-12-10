//
//  HtmlVC.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/10.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HtmlVC.h"

@interface HtmlVC ()<UIWebViewDelegate>
@property (strong, nonatomic)  UIWebView *webView;
@end

@implementation HtmlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webView = [UIWebView new];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.navigationItem.title = self.headerTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    if (self.url == nil) {
        [self.view makeToast:@"无效链接"];
        return;
    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.view makeToastActivity];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
     [self.view hideToastActivity];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
      [self.view hideToastActivity];
      [self.view makeToast:error.description];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
