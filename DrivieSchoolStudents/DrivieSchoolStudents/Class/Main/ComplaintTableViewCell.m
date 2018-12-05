//
//  ComplaintTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "ComplaintTableViewCell.h"

@implementation ComplaintTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)callphone:(id)sender {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_model.phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)setModel:(CModel *)model{
    _model = model;
    _phoneLb.text = model.phone;
    _nameLb.text = model.name;
}
@end
