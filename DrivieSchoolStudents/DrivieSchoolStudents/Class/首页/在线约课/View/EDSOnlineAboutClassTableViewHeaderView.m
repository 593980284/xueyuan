//
//  EDSOnlineAboutClassTableViewHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineAboutClassTableViewHeaderView.h"
#import "EDSTopScrollView.h"

#import "EDSOnlineClassDateListModel.h"

@interface EDSOnlineAboutClassTableViewHeaderView ()

//@property (nonatomic , strong)cyhCalenbarview * cyhcalenbar;
//@property (nonatomic , strong)monthCalenbarview * monthCalenbar;
@property (nonatomic , copy)NSString * daydatestr;

@property (nonatomic , strong)UILabel * dataLbl;

@end

@implementation EDSOnlineAboutClassTableViewHeaderView

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

- (void)setDataArr:(NSArray<EDSOnlineClassDateListModel *> *)dataArr
{
    _dataArr = dataArr;
    
    [self setup];
}

- (void)setup{
    
    _dataLbl = [UILabel labelWithText:@"2018-07" font:[UIFont boldSystemFontOfSize:16] textColor:FirstColor backGroundColor:ClearColor superView:self];
    [_dataLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.centerX.mas_equalTo(0);
    }];
    
    EDSTopScrollView * scrollView = [[EDSTopScrollView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, 76)];
    [scrollView setUserInteractionEnabled:YES];
    [scrollView setScrollEnabled:YES];
    
    //NO - 设置scrollView不能取消传递touch事件，此时就算手指若在subView上滑动，scrollView不滚动; YES - 设置scrollView可取消传递touch事件
    [scrollView setCanCancelContentTouches:YES];
    [scrollView setBounces:NO];
    
    //NO - 立即通知touchesShouldBegin:withEvent:inContentView
    [scrollView setDelaysContentTouches:NO];
    CGFloat viewW = kScreenWidth / 7 ;
    [scrollView setContentSize:CGSizeMake(viewW*self.dataArr.count, 76)];
    @weakify(self);
    scrollView.topScrollViewDidBackData = ^(NSString *datastr) {
        @strongify(self);
        if (self.onlineAboutClassTableViewHeaderViewDidBackData) {
            
            self.onlineAboutClassTableViewHeaderViewDidBackData(datastr);
        }
    };
    
    [self addSubview:scrollView];
//    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.bottom.mas_equalTo(-10);
//        make.top.mas_equalTo(self->_dataLbl.mas_bottom).mas_equalTo(15);
//    }];
    
    scrollView.dataArr = self.dataArr;

    UIView *line = [UIView viewWithBackgroundColor:TableColor superView:self];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
}

@end
