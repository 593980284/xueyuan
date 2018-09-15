//
//  EDSPricePublicViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/15.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSPricePublicViewController.h"

@interface EDSPricePublicViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation EDSPricePublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"价格公示";
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://111.39.245.156:8087/lexiang/dist/index.html#/priceShowindex.html?id=4000001&className&carType"]]];
}



@end
