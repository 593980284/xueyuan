//
//  SchoolStyleVIew.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/9.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "SchoolStyleVIew.h"

@implementation SchoolStyleVIew

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    if (self = [super init]) {
        _imgView = [UIImageView new];
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(190*HC_750Ratio);
        }];
        
        _titleLb = [UILabel new];
        _titleLb.textColor = FirstColor;
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.numberOfLines = 2;
        [_titleLb sizeToFit];
        [self addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(80*HC_750Ratio);
            make.top.mas_equalTo(self.imgView.mas_bottom).offset(7);
            make.right.mas_equalTo(20*HC_750Ratio);
        }];
        
        _flgImgView = [UIImageView new];
        [self addSubview:_flgImgView];
        [_flgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20*HC_750Ratio);
            make.height.mas_equalTo(30*HC_750Ratio);
            make.width.mas_equalTo(40*HC_750Ratio);
            make.top.mas_equalTo(self.imgView.mas_bottom).offset(7);
        }];
        
        [self bk_whenTapped:^{
            self.block(self.model);
        }];
    }
    return self;
}

- (void)setModel:(EDSSchoolStyleModel *)model
{
    _model = model;
    _titleLb.text = model.styleName;
    _flgImgView.image = [UIImage imageNamed:@"图文"];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.showStylePhoto] placeholderImage:[UIImage imageNamed:@"zhanwei-fengcai"]];
}

@end
