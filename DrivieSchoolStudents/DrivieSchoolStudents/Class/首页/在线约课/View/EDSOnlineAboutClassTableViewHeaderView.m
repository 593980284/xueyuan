//
//  EDSOnlineAboutClassTableViewHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineAboutClassTableViewHeaderView.h"
#import "cyhCalenbarview.h"

@interface EDSOnlineAboutClassTableViewHeaderView ()<getdataString>

@property (nonatomic , strong)cyhCalenbarview * cyhcalenbar;
//@property (nonatomic , strong)monthCalenbarview * monthCalenbar;
@property (nonatomic , copy)NSString * daydatestr;

@end

@implementation EDSOnlineAboutClassTableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = WhiteColor;
        [self setup];
    }
    return self;
}


- (instancetype)init
{
    return [self initWithFrame:self.frame];
}


- (void)setup{
    
    //初始化，如果日历小于120.0的高度将默认为120.0高度
    _cyhcalenbar = [[cyhCalenbarview alloc] initD_calenbarframe:CGRectMake(0, 0,kScreenWidth, 130)];
    _cyhcalenbar.daydelegate = self;
    //注册使用
    [_cyhcalenbar daycalenbarviewNSdate];
    
    //日历背景颜色
    _cyhcalenbar.calenbarBGcolor = WhiteColor;
    
    //星期排列背景颜色
    _cyhcalenbar.WeekBGcolor = WhiteColor;
    
    //当天日期圆点颜色
    _cyhcalenbar.todayNumBGcolor = [EDSToolClass getColorWithHexString:@"#FEAE3C"];
    
    //被选中的日期圆点颜色
    _cyhcalenbar.SelecNumBGcolor = ThemeColor;
    
    //当天日期数字颜色
    _cyhcalenbar.todaytextColor = SecondColor;
    
    [self addSubview:_cyhcalenbar.daycalenbarview];
    
    
    UIView *line = [UIView viewWithBackgroundColor:TableColor superView:self];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
}

- (void)getDatestring:(NSString *)datestring
{
    _daydatestr = datestring;
    NSLog(@"回调回来的日期:%@",_daydatestr);
    
}
@end
