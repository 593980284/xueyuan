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
    while (self.subviews.count > 0) {
        [self.subviews.lastObject removeFromSuperview];
    }
    _lineView = [UIView viewWithBackgroundColor:SeparatorCOLOR superView:self];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    UIScrollView *scrollView =[UIScrollView new];
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);

    }];
    _indicatorView = [UIView viewWithBackgroundColor:ThemeColor superView:scrollView];
    NSMutableArray *viewArr = [[NSMutableArray alloc] init];
    
    if (self.btnArr.count > 4) {
        scrollView.contentSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width/4.0)*self.btnArr.count, 40);
    }else{
        scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
    }
    for (int i = 0 ; i < self.btnArr.count; i ++) {
        
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [btn setTitle:self.btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:FirstColor forState:UIControlStateNormal];
        [btn setTitle:self.btnArr[i] forState:UIControlStateSelected];
        [btn setTitleColor:ThemeColor forState:UIControlStateSelected];
        [scrollView addSubview:btn];
        [viewArr addObject:btn];
        @weakify(self);
        [btn bk_whenTapped:^{
            @strongify(self);
            self->_selectBtn.selected = NO;
            btn.selected = YES;
            self->_selectBtn = btn;
            [self indicatorAnimationWithCenterX:btn];
            if (self.headerPageButtonDidSelectStringback) {

                self.headerPageButtonDidSelectStringback(self.btnArr[i]);
            }
            if (self.clickBlock) {
                self.clickBlock(i);
            }
        }];
        CGFloat w = [UIScreen mainScreen].bounds.size.width/self.btnArr.count;
        if (self.btnArr.count > 4) {
            w = [UIScreen mainScreen].bounds.size.width/4;
        }
//        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(w*i);
//            make.width.mas_equalTo(w);
//            make.top.mas_equalTo(0);
//            make.bottom.mas_equalTo(-2);
//        }];
        btn.frame = CGRectMake(w*i, 0, w, 40-2);
        if (i == 0) {
            
            btn.selected = YES;
            _selectBtn = btn;
            
            [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(50, 2));
                make.top.mas_equalTo(39);
                make.centerX.mas_equalTo(btn.mas_centerX);
            }];
        }
    }
    
//    [viewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
//    [viewArr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.bottom.mas_equalTo(-2);
//    }];
}

- (void)indicatorAnimationWithCenterX:(UIButton *)centerX
{
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.indicatorView  mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(50, 2));
            make.top.mas_equalTo(39);
            make.centerX.mas_equalTo(centerX.mas_centerX);
        }];
//        self.indicatorView.wz_centerX = centerX;
    }];
}

@end
