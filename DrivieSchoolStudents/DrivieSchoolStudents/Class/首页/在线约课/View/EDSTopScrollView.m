//
//  EDSTopScrollView.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSTopScrollView.h"
#import "EDSDayView.h"
#import "EDSOnlineClassDateListModel.h"
@interface EDSTopScrollView ()
{
    UIButton *_selectBtn;
    UIView *pointView;
}

@end

@implementation EDSTopScrollView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:WhiteColor];
        
        pointView = [UIView new];
        pointView.backgroundColor = [UIColor colorWithRed:245/255.0 green:174/255.0 blue:75/255.0 alpha:1];
        pointView.center = CGPointMake(kScreenWidth / 7.0 / 2.0, 76-5);
        pointView.bounds = CGRectMake(0, 0, 8, 8);
        pointView.layer.cornerRadius = 4;
        pointView.clipsToBounds = YES;
        
    }
    return self;
}

- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    
    CGFloat W = kScreenWidth / 7;
    for (int i = 0; i < dataArr.count; i ++) {

        EDSDayView * aView = [[EDSDayView alloc] initWithFrame:CGRectMake(W*i, 0, W, 76)];
        aView.onlineClassDateListModel = dataArr[i];
        @weakify(self);
        [aView bk_whenTapped:^{
            @strongify(self);
            self->_selectBtn.selected = NO;
            aView.dayBtn.selected = YES;
            self->_selectBtn = aView.dayBtn;
            if (self.topScrollViewDidBackData) {
                
                self.topScrollViewDidBackData(self.dataArr[i].date);
            }
        }];
        [self addSubview:aView];
        if (i == 0) {
            
            aView.dayBtn.selected = YES;
            _selectBtn = aView.dayBtn;
        }
    }
     [self addSubview:pointView];
}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view {
//    NSLog(@"用户触摸了scroll上的视图%@，是否开始滚动scroll", view);
    //返回yes - 将触摸事件传递给相应的subView; 返回no - 直接滚动scrollView，不传递触摸事件到subView
    return YES;// NO;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
//    NSLog(@"scrollView取消传递触摸事件到视图%@", view);
    //no - 不取消，touch事件由view处理，scrollView不滚动; yes - scrollView取消，touch事件由scrollView处理，可滚动
    return YES;// NO;
}


@end
