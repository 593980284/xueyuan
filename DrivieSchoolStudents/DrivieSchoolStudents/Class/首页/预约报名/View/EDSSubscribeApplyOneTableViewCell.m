//
//  EDSSubscribeApplyOneTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSubscribeApplyOneTableViewCell.h"
@interface EDSSubscribeApplyOneTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *drivingSchoolBgView;
@property (weak, nonatomic) IBOutlet UIView *carTypeBgView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;


@end
@implementation EDSSubscribeApplyOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.backgroundColor = WhiteColor;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.borderColor = SeparatorCOLOR.CGColor;
    self.bgView.layer.borderWidth = 1;
    
    self.drivingSchoolBgView.layer.masksToBounds = YES;
    self.drivingSchoolBgView.layer.cornerRadius = 5;
    self.drivingSchoolBgView.layer.borderColor = SeparatorCOLOR.CGColor;
    self.drivingSchoolBgView.layer.borderWidth = 1;
    
    self.carTypeBgView.layer.masksToBounds = YES;
    self.carTypeBgView.layer.cornerRadius = 5;
    self.carTypeBgView.layer.borderColor = SeparatorCOLOR.CGColor;
    self.carTypeBgView.layer.borderWidth = 1;
    
    @weakify(self);
    [self.drivingSchoolBgView bk_whenTapped:^{
        DLog(@"选择驾校");
        @strongify(self);
        if (self.subscribeApplyOneTableDidSelectStringback) {
            
            self.subscribeApplyOneTableDidSelectStringback(@"选择驾校");
        }
    }];
    
    [self.carTypeBgView bk_whenTapped:^{
        DLog(@"选择车型");
        @strongify(self);
        if (self.subscribeApplyOneTableDidSelectStringback) {
            
            self.subscribeApplyOneTableDidSelectStringback(@"选择车型");
        }
    }];
    
    
    self.drivingSchoolLbl.font = kFont(16);
    self.carTypeLbl.font = kFont(16);
    self.label1.font = kFont(16);
    self.label2.font = kFont(16);
    self.label3.font = kFont(16);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
