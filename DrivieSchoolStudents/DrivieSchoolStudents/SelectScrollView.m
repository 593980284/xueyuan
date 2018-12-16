//
//  SelectScrollView.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "SelectScrollView.h"
#import "SelectBtn.h"
#define item_width 75

@interface SelectScrollView()
@property(nonatomic, strong)NSMutableArray<SelectBtn *> *btns;
@end
@implementation SelectScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithTitles:(NSArray *)titles
{
    if (self = [super init]) {
        _btns = [NSMutableArray new];
        for (int i = 0; i<titles.count; i++) {
            SelectBtn *btn = [SelectBtn new];
            btn.tag = 100+i;
            [btn setTitle:titles[i] forState:0];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [_btns addObject:btn];
            [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            btn.selected = i==0;
            btn.frame = CGRectMake(i*item_width, 0, item_width, 40);
           
        }
        self.contentSize = CGSizeMake(item_width * titles.count, 30);
        self.showsHorizontalScrollIndicator = NO;
        NSLog(@"%lf",self.contentSize.width);
    }
    return self;
}

- (void)btnTap:(UIButton *)sender
{
    for (SelectBtn* btn in self.btns) {
        btn.selected = NO;
    }
    
    NSInteger index = sender.tag - 100;
    _btns[index].selected = YES;
    self.block(_btns[index].currentTitle);
}
@end
