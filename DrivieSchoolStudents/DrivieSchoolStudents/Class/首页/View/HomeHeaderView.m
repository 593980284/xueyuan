//
//  HomeHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/9.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HomeHeaderView.h"
#import <Masonry/Masonry.h>

@implementation HomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _bgImgView = [UIImageView new];
        [self.contentView addSubview:_bgImgView];
        [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.right.mas_equalTo(30*HC_750Ratio);
            make.top.mas_equalTo(20*HC_750Ratio);
        }];
        _titleLb = [UILabel new];
        [_titleLb sizeToFit];
        [_bgImgView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.bgImgView);
        }];
        _detailLb = [UILabel new];
        _detailLb.textColor = ThirdColor;
        _detailLb.textAlignment = 1;
        _detailLb.font = [UIFont systemFontOfSize:10];
        [_bgImgView addSubview:_detailLb];
        [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLb.mas_bottom);
            make.bottom.left.right.mas_equalTo(0);
        }];
        
    }
    return self;
}
@end
