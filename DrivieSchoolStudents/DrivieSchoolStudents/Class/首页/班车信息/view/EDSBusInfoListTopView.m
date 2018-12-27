//
//  EDSBusInfoListTopView.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/25.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSBusInfoListTopView.h"
@interface EDSBusInfoListTopView()

@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UILabel *rightLabel;
@end

@implementation EDSBusInfoListTopView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}
-(void)initView{
    _leftLabel = [UILabel labelWithText:@"站点名称" font:[UIFont systemFontOfSize:13] textColor:[UIColor greenColor] backGroundColor:[UIColor whiteColor] superView:self];
    _leftLabel.clipsToBounds = YES;
    _leftLabel.layer.cornerRadius = 2;
    _leftLabel.layer.borderWidth = 1;
    _leftLabel.layer.borderColor = [UIColor greenColor].CGColor;
    _leftLabel.textAlignment = NSTextAlignmentCenter;
    
    _rightLabel = [UILabel labelWithText:@"预计发车时间" font:[UIFont systemFontOfSize:13] textColor:[UIColor yellowColor] backGroundColor:[UIColor whiteColor] superView:self];
    _rightLabel.clipsToBounds = YES;
    _rightLabel.layer.cornerRadius = 2;
    _rightLabel.layer.borderWidth = 1;
    _rightLabel.layer.borderColor = [UIColor yellowColor].CGColor;
    _rightLabel.textAlignment = NSTextAlignmentCenter;

    [self setConstraint];
    

    
    
}
-(void)setConstraint{
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        make.top.equalTo(self).offset(10);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLabel.mas_right).offset(50);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
        make.top.equalTo(self).offset(10);
    }];
}

@end
