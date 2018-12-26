//
//  SelectView.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "SelectView.h"
@implementation SelectViewBtn
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
            make.width.mas_equalTo(40);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(0);
        }];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(self.titleLabel.mas_width).offset(20);
        }];
        
        [self initData];
        self.selected = YES;
        
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
@implementation SelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithData:(NSArray *)titles
{
    self.btns = [NSMutableArray new];
    self.backgroundColor = [UIColor whiteColor];
    if (self = [super init]) {
        for (int i = 0; i<titles.count; i++) {
            SelectViewBtn *btn = [SelectViewBtn new];
            btn.tag = 100+i;
            [btn setTitle:titles[i] forState:0];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            btn.selected = i==0;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                if (i == 0) {
                    make.left.mas_equalTo(0);
                }else{
                    make.left.mas_equalTo(self.btns.lastObject.mas_right);
                    make.width.mas_equalTo(self.btns.lastObject.mas_width);
                }
                if (i == titles.count -1) {
                     make.right.mas_equalTo(0);
                }
               
            }];
            
              [_btns addObject:btn];
        }
    }
    return self;
}

- (void)btnTap:(UIButton *)sender
{
    for (SelectViewBtn* btn in self.btns) {
        btn.selected = NO;
    }
    
    NSInteger index = sender.tag - 100;
    _btns[index].selected = YES;
    self.block(index);
}
@end
