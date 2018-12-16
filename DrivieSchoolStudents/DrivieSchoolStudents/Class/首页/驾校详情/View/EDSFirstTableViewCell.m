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
        UIView *view = [UIView new];
        view.backgroundColor = WhiteColor;
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(13);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-15);
        }];
        view.layer.cornerRadius = 5;
        view.clipsToBounds = YES;
        _descripLbl = [UILabel labelWithText:@"" font:kFont(13) textColor:FirstColor backGroundColor:ClearColor superView:self.contentView];
        _descripLbl.textAlignment = NSTextAlignmentLeft;
        _descripLbl.numberOfLines = 0;
        [_descripLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(27);
            make.top.mas_equalTo(13+5);
            make.right.mas_equalTo(-15-7);
            make.bottom.mas_equalTo(-15-5);
        }];
    
    }
    return  _descripLbl;
}
@end
