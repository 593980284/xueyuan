//
//  SelectBtn.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "SelectBtn.h"

@implementation SelectBtn

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
        _lineLb = [UIImageView new];
        _lineLb.image = [UIImage imageNamed:@"tab_bg_y"];
        _bgView = [UIImageView new];
        _bgView.image = [UIImage imageNamed:@"tab_bg_x"];
        [self addSubview:_lineLb];
        [self addSubview:_bgView];
        
        [_lineLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(0);
        }];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(60);
        }];
        
        [self initData];
        
    }
    return self;
}

- (void)initData
{
    self.selectColor = [UIColor colorWithRed:100/255.0 green:150/255.0 blue:240/255.0 alpha:1];
    self.nomalColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
}

- (void)setSelectColor:(UIColor *)selectColor
{
    _selectColor = selectColor;
    self.lineLb.backgroundColor = selectColor;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}

- (void)setNomalColor:(UIColor *)nomalColor
{
    _nomalColor = nomalColor;
    [self setTitleColor:[UIColor blackColor] forState:0];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.lineLb.hidden = !selected;
    self.bgView.hidden = !selected;
    
}

@end
