//
//  StyleTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/9.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "StyleTableViewCell.h"

@implementation StyleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _leftView = [SchoolStyleVIew new];
        _rightView = [SchoolStyleVIew new];
        [self.contentView addSubview:_leftView];
        [self.contentView addSubview:_rightView];
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(20*HC_750Ratio);
            make.width.mas_equalTo(330*HC_750Ratio);
            make.left.mas_equalTo(30*HC_750Ratio);
        }];
        [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(20*HC_750Ratio);
            make.width.mas_equalTo(330*HC_750Ratio);
            make.left.mas_equalTo(self.leftView.mas_right).offset(30*HC_750Ratio);
        }];
        
    }
    return self;
}
@end
