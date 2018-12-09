//
//  EDSDriverNavHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/9.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSDriverNavHeaderView.h"
//#import

@interface EDSDriverNavHeaderView()

@property (nonatomic,strong) NSArray *titleArr;


@end

@implementation EDSDriverNavHeaderView

-(instancetype)initWithTitleArr:(NSArray *)titleArr{
    if (self = [self initWithFrame:CGRectZero]) {
        self.titleArr = titleArr;
        [self initView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.wz_height = 50;
        self.wz_width = kScreenWidth;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)initView{
    if (self.titleArr.count > 0) {
        NSLog(@"%lf",kScreenWidth);
        NSInteger itemNumber = self.titleArr.count;
        CGFloat itemWidth = kScreenWidth/(CGFloat)itemNumber;
        NSLog(@"%lf",itemWidth);
        CGFloat itemHeight = 50;
        CGFloat btnWidth = 40;
        
        UIColor *normalBtnColor = [UIColor lightGrayColor];
        UIColor *selectBtnColor = [UIColor redColor];
        
        for (NSInteger index = 0; index <itemNumber; index ++) {
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(index * itemWidth, 0, itemWidth, itemHeight)];
            UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [titleBtn setFrame:CGRectMake(0, 0, btnWidth, 30)];
            titleBtn.backgroundColor= [UIColor redColor];
            titleBtn.center = CGPointMake(bgView.wz_width/2, bgView.wz_height/2) ;
            [titleBtn setTitle:self.titleArr[index] forState:UIControlStateNormal];
            [titleBtn setTitleColor:normalBtnColor forState:UIControlStateNormal];
            [titleBtn setTitleColor:selectBtnColor forState:UIControlStateSelected];
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            titleBtn.tag = 100 + index;
            
            [bgView addSubview:titleBtn];
            [self addSubview:bgView];
        }
        
    }else{
        self.wz_height = 0;
    }
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
