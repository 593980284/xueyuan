//
//  EDSDayView.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSDayView.h"
#import "EDSOnlineClassDateListModel.h"

@implementation EDSDayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = WhiteColor;
    }
    return self;
}


- (void)setOnlineClassDateListModel:(EDSOnlineClassDateListModel *)onlineClassDateListModel
{
    _onlineClassDateListModel = onlineClassDateListModel;
    
    [self setup];
}


- (void)setup{
    
    UILabel *weekLbl = [UILabel labelWithText:self.onlineClassDateListModel.showWeak font:kFont(16) textColor:SecondColor backGroundColor:ClearColor superView:self];
    [weekLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
    }];
    
    _dayBtn = [[UIButton alloc] init];
    [_dayBtn setBackgroundImage:[UIImage imageNamed:@"round_content_icon"] forState:UIControlStateSelected];
    [_dayBtn setTitle:self.onlineClassDateListModel.showDay forState:UIControlStateNormal];
    [_dayBtn setTitle:self.onlineClassDateListModel.showDay forState:UIControlStateSelected];
    [_dayBtn setTitleColor:SecondColor forState:UIControlStateNormal];
    [_dayBtn setTitleColor:WhiteColor forState:UIControlStateSelected];
    [self addSubview:_dayBtn];
    [_dayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(39, 40));
        make.top.mas_equalTo(weekLbl.mas_bottom).mas_equalTo(3);
        make.centerX.mas_equalTo(0);
    }];
    _dayBtn.userInteractionEnabled = NO;
    
    UIView *tageView = [UIView viewWithBackgroundColor:[EDSToolClass getColorWithHexString:@"#FEAE3C"] superView:self];
    [tageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(8, 8));
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self->_dayBtn.mas_bottom);
    }];
    tageView.layer.cornerRadius = 4;
    tageView.layer.masksToBounds = YES;
    tageView.hidden = self.onlineClassDateListModel.isSubject;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}


@end
