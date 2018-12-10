//
//  EDSMessageDetailTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/4.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSMessageDetailTableViewCell.h"

@interface EDSMessageDetailTableViewCell ()

@property (nonatomic,strong) UIView *bgView;


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
        
    }
    return self;
}

- (void)setIsQuestion:(BOOL)isQuestion
{
    _isQuestion = isQuestion;
    
    if (isQuestion) {
        self.typeLbl.backgroundColor = ThemeColor;
        self.typeLbl.text = @"Q";
    }else{
        
        self.typeLbl.backgroundColor = [EDSToolClass getColorWithHexString:@"#FF4F4F"];
        self.typeLbl.text = @"A";
    }
}



-(UIView *)bgView{
    if (!_bgView) {
        _bgView =[UIView viewWithBackgroundColor:WhiteColor superView:self.contentView];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(5);
//            make.height.mas_equalTo(200);
        }];
        
        _bgView.clipsToBounds = YES;
        _bgView.layer.cornerRadius = 10;
    }
    return _bgView;
}
- (UILabel *)typeLbl
{
    if (!_typeLbl) {
        
//        _typeLbl = [UILabel labelWithText:@"Q" font:[UIFont boldSystemFontOfSize:20] textColor:WhiteColor backGroundColor:ThemeColor superView:self.contentView];
        _typeLbl = [UILabel labelWithText:@"Q" font:[UIFont boldSystemFontOfSize:20] textColor:WhiteColor backGroundColor:ThemeColor superView:self.bgView];
        _typeLbl.textAlignment = NSTextAlignmentCenter;
        _typeLbl.layer.cornerRadius = 5;
        _typeLbl.layer.masksToBounds = YES;
        [_typeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
    }
    return _typeLbl;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
//        _titleLbl = [UILabel labelWithText:@"标题信息标题信息标题信息" font:[UIFont boldSystemFontOfSize:18] textColor:FirstColor backGroundColor:ClearColor superView:self.contentView];
        _titleLbl = [UILabel labelWithText:@"标题信息标题信息标题信息" font:[UIFont boldSystemFontOfSize:18] textColor:FirstColor backGroundColor:ClearColor superView:self.bgView];
        [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.typeLbl.mas_right).mas_equalTo(11);
            make.centerY.mas_equalTo(self.typeLbl.mas_centerY);
        }];
    }
    return _titleLbl;
}

- (UILabel *)descrpLbl
{
    if (!_descrpLbl) {
//        _descrpLbl = [UILabel labelWithText:@"      内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内" font:kFont(16) textColor:FirstColor backGroundColor:ClearColor superView:self.contentView];
        _descrpLbl = [UILabel labelWithText:@"内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内" font:kFont(16) textColor:FirstColor backGroundColor:ClearColor superView:self.bgView];
        [_descrpLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
//            make.top.mas_equalTo(self.titleLbl.mas_bottom).mas_equalTo(15);
            make.top.mas_equalTo(self.timeLbl.mas_bottom).mas_equalTo(15);
            make.bottom.mas_equalTo(-15);
            make.right.mas_equalTo(-15);
        }];
    }
    return _descrpLbl;
}

- (UILabel *)timeLbl
{
    if (!_timeLbl) {
        
//        _timeLbl = [UILabel labelWithText:@"2018-07-18 10:00:00" font:kFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self.contentView];
        _timeLbl = [UILabel labelWithText:@"2018-07-18 10:00:00" font:kFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self.bgView];

        [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-15);
//            make.top.mas_equalTo(self.descrpLbl.mas_bottom).mas_equalTo(23);
             make.top.mas_equalTo(self.titleLbl.mas_bottom).mas_equalTo(15);
//            make.bottom.mas_equalTo(-15);
        }];
    }
    return _timeLbl;
}

@end
