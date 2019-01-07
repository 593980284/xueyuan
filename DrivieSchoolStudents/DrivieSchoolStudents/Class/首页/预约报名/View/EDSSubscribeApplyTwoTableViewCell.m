//
//  EDSSubscribeApplyTwoTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSubscribeApplyTwoTableViewCell.h"

@interface EDSSubscribeApplyTwoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *timeBgView;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;

@end

@implementation EDSSubscribeApplyTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bgView.backgroundColor = WhiteColor;
//    self.bgView.layer.masksToBounds = YES;
//    self.bgView.layer.cornerRadius = 5;
//    self.bgView.layer.borderColor = SeparatorCOLOR.CGColor;
//    self.bgView.layer.borderWidth = 1;
    self.contentView.backgroundColor = WhiteColor;
    
    UIView *view = [UIView new];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 5;
       view.layer.borderColor = RGBCOLOR(246, 246, 246).CGColor;
      view.layer.borderWidth = 1;
    [self.bgView insertSubview:view atIndex:0 ];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(55);
    }];
    
//    self.nameTextF.layer.masksToBounds = YES;
//    self.nameTextF.layer.cornerRadius = 5;
//    self.nameTextF.layer.borderColor = SeparatorCOLOR.CGColor;
//    self.nameTextF.layer.borderWidth = 1;
//
//    self.codeTextF.layer.masksToBounds = YES;
//    self.codeTextF.layer.cornerRadius = 5;
//    self.codeTextF.layer.borderColor = SeparatorCOLOR.CGColor;
//    self.codeTextF.layer.borderWidth = 1;
//
//    self.phoneTextF.layer.masksToBounds = YES;
//    self.phoneTextF.layer.cornerRadius = 5;
//    self.phoneTextF.layer.borderColor = SeparatorCOLOR.CGColor;
//    self.phoneTextF.layer.borderWidth = 1;
//
//    self.timeBgView.layer.masksToBounds = YES;
//    self.timeBgView.layer.cornerRadius = 5;
//    self.timeBgView.layer.borderColor = SeparatorCOLOR.CGColor;
//    self.timeBgView.layer.borderWidth = 1;
    
    [self.timeBgView bk_whenTapped:^{
       
        if (self.subscribeApplyTwoTableDidSelectStringback) {
            
            self.subscribeApplyTwoTableDidSelectStringback(@"选择时间");
        }
    }];
    
    [self.nameTextF setBk_shouldChangeCharactersInRangeWithReplacementStringBlock:^BOOL(UITextField *textF, NSRange range, NSString *string) {
        
        NSString *comcatstr = [textF.text stringByReplacingCharactersInRange:range withString:string];
        
        NSInteger caninputlen = 50 - comcatstr.length;
        
        if (caninputlen >= 0)
        {
            return YES;
        }
        else
        {
            NSInteger len = string.length + caninputlen;
            //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
            NSRange rg = {0,MAX(len,0)};
            
            if (rg.length > 0)
            {
                NSString *s = [string substringWithRange:rg];
                
                [textF setText:[textF.text stringByReplacingCharactersInRange:range withString:s]];
            }
            return NO;
        }
    }];
    
    @weakify(self);
    [self.codeTextF setBk_didEndEditingBlock:^(UITextField *textF) {
        @strongify(self);
        if (textF.text.length == 15 || textF.text.length == 18) {
            
            self.codeTextF.text = textF.text;
        }else{
            self.codeTextF.text = @"";
//            [SVProgressHUD showErrorWithStatus:@"请输入正确的身份证号"];
//            [SVProgressHUD dismissWithDelay:1];
            [[self currentViewController].view makeToast:@"请输入正确的身份证号"];
        }
    }];
    
    [self.phoneTextF setBk_didEndEditingBlock:^(UITextField *textF) {
        @strongify(self);
        if (textF.text.length == 11) {
            self.phoneTextF.text = textF.text;
        }else{
            
            self.phoneTextF.text = @"";
//            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
//            [SVProgressHUD dismissWithDelay:1];
            [[self currentViewController].view makeToast:@"请输入正确的手机号码"];
        }
    }];
    
    self.nameTextF.font = kFont(16);
    self.codeTextF.font = kFont(16);
    self.phoneTextF.font = kFont(16);
    self.timeLbl.font = kFont(16);
    self.label1.font = kFont(16);
    self.label2.font = kFont(16);
    self.label3.font = kFont(16);
    self.label4.font = kFont(16);
    self.label5.font = kFont(16);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
