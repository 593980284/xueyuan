//
//  EDSFirstTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSFirstTableViewCell.h"

@interface EDSFirstTableViewCell ()
/**  */
@end

@implementation EDSFirstTableViewCell

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
        
        self.descripLbl.text = @"";
    }
    return self;
}

- (UILabel *)descripLbl
{
    if (!_descripLbl) {
        
        _descripLbl = [UILabel labelWithText:@"" font:kFont(16) textColor:FirstColor backGroundColor:ClearColor superView:self.contentView];
        _descripLbl.textAlignment = NSTextAlignmentLeft;
        _descripLbl.numberOfLines = 0;
        [_descripLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(13);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-15);
        }];
    }
    return  _descripLbl;
}
@end
