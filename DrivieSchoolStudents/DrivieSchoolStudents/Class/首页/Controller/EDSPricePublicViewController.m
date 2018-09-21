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
    
    if (self.schoolID.length > 0) {
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?id=%@",JGGS,self.schoolID]]]];
    }else{
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:JGGS]]];
    }
}

- (void)setSchoolID:(NSString *)schoolID
{
    _schoolID = schoolID;
}

@end
