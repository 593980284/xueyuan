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

static const NSInteger MAX_LIMIT_NUMS = 500;

@interface EDSSchoolMessageViewController ()<UITextViewDelegate>{
	BOOL isAdvice;
}
@property (weak, nonatomic) IBOutlet UIView *chooseView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation EDSSchoolMessageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	isAdvice = YES;
    self.navigationItem.title = @"学校信箱";
    
    self.chooseView.layer.borderWidth = 1;
    self.chooseView.layer.borderColor = [EDSToolClass getColorWithHexString:@"#ECE9E9"].CGColor;
    
    self.textView.placeholder = @"请留下您的宝贵意见,我们努力改进。(请不少于五个字)";
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [EDSToolClass getColorWithHexString:@"#ECE9E9"].CGColor;
    self.textView.delegate = self;
    
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
    }
    
    //不让显示负数
//    self.lbNums.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,MAX_LIMIT_NUMS - existTextNum),MAX_LIMIT_NUMS];
}



- (IBAction)adviceBtnClick:(id)sender {
	self.complaintBtn.selected = NO;
	self.complaintImage.image = [UIImage imageNamed:@"ic-wxz"];
	
	self.adviceBtn.selected = YES;
	self.adviceImage.image = [UIImage imageNamed:@"ic-xz"];
	isAdvice = YES;
}

- (IBAction)complaint:(id)sender {
	self.complaintBtn.selected = YES;
	self.complaintImage.image = [UIImage imageNamed:@"ic-xz"];
	
	self.adviceBtn.selected = NO;
	self.adviceImage.image = [UIImage imageNamed:@"ic-wxz"];
	isAdvice = NO;
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
        request.type = isAdvice ? @"1" : @"0";
        request.pubContent = self.textView.text;
        request.showHUD = YES;
        [request  startRequest];
    }else
    {
//        [SVProgressHUD showErrorWithStatus:@"请输入您的意见"];
//        [SVProgressHUD dismissWithDelay:1.5];
        [self.view makeToast:@"请输入您的意见"];
    }
    
}

@end
