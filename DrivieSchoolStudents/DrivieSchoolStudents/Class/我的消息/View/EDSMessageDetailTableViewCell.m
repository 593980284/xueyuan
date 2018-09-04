//
//  EDSMessageDetailTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/4.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSMessageDetailTableViewCell.h"

@interface EDSMessageDetailTableViewCell ()

@property (nonatomic, strong) UILabel  *typeLbl;
@property (nonatomic, strong) UILabel  *titleLbl;
@property (nonatomic, strong) UILabel  *descrpLbl;
@property (nonatomic, strong) UILabel  *timeLbl;

@end

@implementation EDSMessageDetailTableViewCell

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
        
        [self setup];
    }
    return self;
}

- (void)setIsQuestion:(BOOL)isQuestion
{
    _isQuestion = isQuestion;
    
    if (isQuestion) {
        
        _typeLbl.backgroundColor = ThemeColor;
        _typeLbl.text = @"Q";
    }else{
        
        _typeLbl.backgroundColor = [EDSToolClass getColorWithHexString:@"#FF4F4F"];
        _typeLbl.text = @"A";
    }
}

- (void)setup{
    
    
    _typeLbl = [UILabel labelWithText:@"Q" font:[UIFont boldSystemFontOfSize:20] textColor:WhiteColor backGroundColor:ThemeColor superView:self.contentView];
    _typeLbl.textAlignment = NSTextAlignmentCenter;
    _typeLbl.layer.cornerRadius = 5;
    _typeLbl.layer.masksToBounds = YES;
    [_typeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    _titleLbl = [UILabel labelWithText:@"标题信息标题信息标题信息" font:[UIFont boldSystemFontOfSize:18] textColor:FirstColor backGroundColor:ClearColor superView:self.contentView];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_typeLbl.mas_right).mas_equalTo(11);
        make.centerY.mas_equalTo(self->_typeLbl.mas_centerY);
    }];
    
    _descrpLbl = [UILabel labelWithText:@"      内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内" font:kFont(16) textColor:FirstColor backGroundColor:ClearColor superView:self.contentView];
    [_descrpLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self->_titleLbl.mas_bottom).mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    _titleLbl = [UILabel labelWithText:@"2018-07-18 10:00:00" font:kFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self.contentView];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self->_descrpLbl.mas_bottom).mas_equalTo(23);
        make.bottom.mas_equalTo(-15);
    }];
}

@end
