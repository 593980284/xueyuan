//
//  EDSSchoolMessageViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSchoolMessageViewController.h"
#import <UITextView+Placeholder.h>

@interface EDSSchoolMessageViewController ()
@property (weak, nonatomic) IBOutlet UIView *chooseView;
@property (weak, nonatomic) IBOutlet UILabel *chooseLbl;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation EDSSchoolMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"学校信箱";
    
    self.chooseView.layer.borderWidth = 1;
    self.chooseView.layer.borderColor = [EDSToolClass getColorWithHexString:@"#ECE9E9"].CGColor;
    
    self.textView.placeholder = @"请留下您的宝贵意见,我们努力改进。(请不少于五个字)";
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [EDSToolClass getColorWithHexString:@"#ECE9E9"].CGColor;
    
}



@end
