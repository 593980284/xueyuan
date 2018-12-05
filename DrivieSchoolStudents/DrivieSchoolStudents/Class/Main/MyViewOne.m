//
//  MyViewOne.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "MyViewOne.h"
#import "MyButton2.h"
@implementation MyViewOne

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithData:(NSArray *)data{
    if (self = [super init]) {
        _data = data;
        _btns = [NSMutableArray new];
        UIScrollView *scrollView = [UIScrollView new];
        [self addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self);
        }];
        self.hidden = YES;
        scrollView.contentSize = CGSizeMake(kScreenWidth, 45*data.count);
        for (int i = 0; i< data.count; i++) {
            MyButton2 *btn = [MyButton2 new];
            btn.selected = i == 0;
            btn.backgroundColor = [UIColor whiteColor];
            btn.frame = CGRectMake(0, 45*i, kScreenWidth, 45);
            [btn setTitle:data[i][@"name"] forState: 0];
            [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:btn];
            [_btns addObject:btn];
            btn.tag = 1000 + i;
        }
        
    }
    
    [self bk_whenTapped:^{
        self.hidden = YES;
        self.missBlock();
    }];
    
    return self;
}

- (void)btnTap:(UIButton *)btn{
//    if (btn.selected) {
//        return;
//    }
    for (UIButton * b in _btns) {
        b.selected = NO;
    }
      btn.selected = YES;
    NSDictionary *dic = _data[[_btns indexOfObject:btn]];
    self.btnTapBlock(dic[@"name"], dic[@"code"]);
    self.hidden = YES;
}

@end
