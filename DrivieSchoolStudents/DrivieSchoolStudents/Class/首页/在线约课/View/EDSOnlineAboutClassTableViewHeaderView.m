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

@property (nonatomic , strong) EDSTopScrollView * scrollView;

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
    
    self.dataLbl.text = self.dataArr[0].date;
    
    self.scrollView.dataArr = self.dataArr;
}


- (EDSTopScrollView *)scrollView
{
    if (!_scrollView) {
        
        _scrollView = [[EDSTopScrollView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, 76)];
        [_scrollView setUserInteractionEnabled:YES];
        [_scrollView setScrollEnabled:YES];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        //NO - 设置scrollView不能取消传递touch事件，此时就算手指若在subView上滑动，scrollView不滚动; YES - 设置scrollView可取消传递touch事件
        [_scrollView setCanCancelContentTouches:YES];
        [_scrollView setBounces:NO];
        
        //NO - 立即通知touchesShouldBegin:withEvent:inContentView
        [_scrollView setDelaysContentTouches:NO];
        CGFloat viewW = kScreenWidth / 7 ;
        [_scrollView setContentSize:CGSizeMake(viewW*self.dataArr.count, 76)];
        @weakify(self);
        _scrollView.topScrollViewDidBackData = ^(NSString *datastr) {
            @strongify(self);
            
            self->_dataLbl.text = datastr;
            if (self.onlineAboutClassTableViewHeaderViewDidBackData) {
                
                self.onlineAboutClassTableViewHeaderViewDidBackData(datastr);
            }
        };
        
        [self addSubview:_scrollView];
        UIView *line = [UIView viewWithBackgroundColor:TableColor superView:self];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(10);
        }];
    }
    return _scrollView;
}

- (UILabel *)dataLbl
{
    if (!_dataLbl) {
        
        _dataLbl = [UILabel labelWithText:@"" font:[UIFont boldSystemFontOfSize:16] textColor:FirstColor backGroundColor:ClearColor superView:self];
        [_dataLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.centerX.mas_equalTo(0);
        }];
    }
    return _dataLbl;
}

@end
