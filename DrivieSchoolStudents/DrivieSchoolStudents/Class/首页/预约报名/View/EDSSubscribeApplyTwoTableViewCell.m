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

@property (weak, nonatomic) IBOutlet UITextField *nameTextF;
@property (weak, nonatomic) IBOutlet UITextField *codeTextF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UIView *timeBgView;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@end

@implementation EDSSubscribeApplyTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bgView.backgroundColor = WhiteColor;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.borderColor = SeparatorCOLOR.CGColor;
    self.bgView.layer.borderWidth = 1;
    
    
    self.nameTextF.layer.masksToBounds = YES;
    self.nameTextF.layer.cornerRadius = 5;
    self.nameTextF.layer.borderColor = SeparatorCOLOR.CGColor;
    self.nameTextF.layer.borderWidth = 1;
    
    self.codeTextF.layer.masksToBounds = YES;
    self.codeTextF.layer.cornerRadius = 5;
    self.codeTextF.layer.borderColor = SeparatorCOLOR.CGColor;
    self.codeTextF.layer.borderWidth = 1;
    
    self.phoneTextF.layer.masksToBounds = YES;
    self.phoneTextF.layer.cornerRadius = 5;
    self.phoneTextF.layer.borderColor = SeparatorCOLOR.CGColor;
    self.phoneTextF.layer.borderWidth = 1;
    
    self.timeBgView.layer.masksToBounds = YES;
    self.timeBgView.layer.cornerRadius = 5;
    self.timeBgView.layer.borderColor = SeparatorCOLOR.CGColor;
    self.timeBgView.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
