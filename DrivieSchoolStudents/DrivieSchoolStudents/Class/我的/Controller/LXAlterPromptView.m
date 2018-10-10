//
//  LXAlterPromptView.m
//  LXCoach
//
//  Created by GDD on 2018/9/12.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "LXAlterPromptView.h"

@interface LXAlterPromptView ()
/**
 提示语
 */
@property (nonatomic, strong) UILabel *alterLabel;
/// 分割线
@property (nonatomic, strong) UIView *breakLine;
/// 取消按钮
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView    *middleBreakLine;
/// 确定按钮
@property (nonatomic, strong) UIButton *enterBtn;
@end

@implementation LXAlterPromptView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        self.layer.cornerRadius = 5;
        [self addSubview:self.alterLabel];
        [self addSubview:self.breakLine];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.middleBreakLine];
        [self addSubview:self.enterBtn];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 38;
    CGFloat w = self.wz_width;
    CGFloat h = 17;
    self.alterLabel.frame = CGRectMake(x, y, w, h);
    
    x = 0;
    y = self.wz_height - 45.5;
    w = self.wz_width;
    h = .5;
    self.breakLine.frame = CGRectMake(x, y, w, h);
    
    x = 0;
    y = CGRectGetMaxY(self.breakLine.frame);
    w = self.wz_width/2;
    h = 45;
    self.cancelBtn.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.cancelBtn.frame);
    y = CGRectGetMaxY(self.breakLine.frame);
    w = .5;
    h = 45;
    self.middleBreakLine.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.middleBreakLine.frame);
    y = CGRectGetMaxY(self.breakLine.frame);
    w = self.wz_width / 2;
    h = 45;
    self.enterBtn.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Event
- (void)cancelBtnAction {
    if ([self.delegate respondsToSelector:@selector(lx_cancelClickButton)]) {
        [self.delegate lx_cancelClickButton];
    }
}
- (void)enterBtnAction {
    if ([self.delegate respondsToSelector:@selector(lx_enterClickButton)]) {
        [self.delegate lx_enterClickButton];
    }
}
#pragma mark - setter
- (void)setAlterString:(NSString *)alterString {
    _alterString = alterString;
    self.alterLabel.text = self.alterString;
}
#pragma mark - getter
- (UILabel *)alterLabel {
    if (!_alterLabel) {
        _alterLabel = [[UILabel alloc] init];
        _alterLabel.font = [UIFont systemFontOfSize:17];
        _alterLabel.textColor = [EDSToolClass getColorWithHexString:@"#333333"];
        _alterLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _alterLabel;
}

- (UIView *)breakLine {
    if (!_breakLine) {
        _breakLine = [[UIView alloc] init];
        _breakLine.backgroundColor = [EDSToolClass getColorWithHexString:@"#DDDDDD"];
    }
    return _breakLine;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn  setTitleColor:[EDSToolClass getColorWithHexString:@"#309CF5"] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UIView *)middleBreakLine {
    if (!_middleBreakLine) {
        _middleBreakLine = [[UIView alloc] init];
        _middleBreakLine.backgroundColor = [EDSToolClass getColorWithHexString:@"#DDDDDD"];
    }
    return _middleBreakLine;
}
- (UIButton *)enterBtn {
    if (!_enterBtn) {
        _enterBtn = [[UIButton alloc] init];
        [_enterBtn setTitleColor:[EDSToolClass getColorWithHexString:@"#666666"] forState:UIControlStateNormal];
        _enterBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_enterBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_enterBtn addTarget:self action:@selector(enterBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterBtn;
}

@end
