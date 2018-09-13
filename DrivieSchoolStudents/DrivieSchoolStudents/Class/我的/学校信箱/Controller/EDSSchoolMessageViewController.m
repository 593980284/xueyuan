//
//  EDSSchoolMessageViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSchoolMessageViewController.h"
#import <UITextView+Placeholder.h>

#import "EDSSaveMailInfoRequest.h"

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
    
    @weakify(self);
    [self.chooseView bk_whenTapped:^{
        @strongify(self);
        
        UIAlertController *alerController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"投诉信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            self.chooseLbl.text = @"投诉信息";
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"改进意见" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            self.chooseLbl.text = @"改进意见";
        }];
        
        [alerController addAction:okAction];
        [alerController addAction:cancelAction];
        [self presentViewController:alerController animated:YES completion:nil];
    }];
    
    
}


- (IBAction)commitClick:(id)sender {
    
    if (self.textView.text.length > 0) {
        
        EDSSaveMailInfoRequest *request = [EDSSaveMailInfoRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
            
            if (errCode == 1) {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        } failureBlock:^(NSError *error) {
            
        }];
        request.phone = [EDSSave account].phone;
        request.type = [self.chooseLbl.text isEqualToString:@"投诉信息"] ? @"0" : @"1";
        request.pubContent = self.textView.text;
        [request  startRequest];
    }else
    {
        [SVProgressHUD showErrorWithStatus:@"请输入您的意见"];
        [SVProgressHUD dismissWithDelay:1.5];
    }
    
}

@end
