//
//  EDSHeaderPageButtonView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSHeaderPageButtonView.h"

@interface EDSHeaderPageButtonView ()
{
    UIButton *_selectBtn;
}

/** 线条 */
@property (nonatomic, strong) UIView  *lineView;
/** 指示器 */
@property (nonatomic, strong) UIView  *indicatorView;

@end

@implementation EDSHeaderPageButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WhiteColor;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

- (void)setBtnArr:(NSArray *)btnArr
{
    _btnArr = btnArr;
    [self setup];
}

- (void)setup{
    
    _lineView = [UIView viewWithBackgroundColor:SeparatorCOLOR superView:self];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    _indicatorView = [UIView viewWithBackgroundColor:ThemeColor superView:self];
    
    NSMutableArray *viewArr = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < self.btnArr.count; i ++) {
        
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [btn setTitle:self.btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:FirstColor forState:UIControlStateNormal];
        [btn setTitle:self.btnArr[i] forState:UIControlStateSelected];
        [btn setTitleColor:ThemeColor forState:UIControlStateSelected];
        [self addSubview:btn];
        [viewArr addObject:btn];
        @weakify(self);
        [btn bk_whenTapped:^{
            @strongify(self);
            self->_selectBtn.selected = NO;
            btn.selected = YES;
            self->_selectBtn = btn;
            [self indicatorAnimationWithCenterX:btn.wz_centerX];
            if (self.headerPageButtonDidSelectStringback) {
                
                self.headerPageButtonDidSelectStringback(self.btnArr[i]);
            }
        }];
        if (i == 0) {
            
            btn.selected = YES;
            _selectBtn = btn;
            
            [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(50, 2));
                make.bottom.mas_equalTo(0);
                make.centerX.mas_equalTo(btn.mas_centerX);
            }];
        }
    }
    
    [viewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [viewArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-2);
    }];
}

- (void)indicatorAnimationWithCenterX:(CGFloat)centerX
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.indicatorView.wz_centerX = centerX;
    }];
}

@end
