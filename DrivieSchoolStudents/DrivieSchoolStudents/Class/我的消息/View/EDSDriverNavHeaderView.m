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
@property (nonatomic,weak) UIButton *selectBtn;
@property (nonatomic,strong) UIView *indexView;

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
        CGFloat btnWidth = 60;
        CGFloat btnHeight = 25;
        
//        UIColor *normalBtnColor = [UIColor lightGrayColor];
//        UIColor *selectBtnColor = [UIColor redColor];
        
        for (NSInteger index = 0; index <itemNumber; index ++) {
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(index * itemWidth, 0, itemWidth, itemHeight)];
            UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [titleBtn setFrame:CGRectMake(0, 0, btnWidth, btnHeight)];
            titleBtn.center = CGPointMake(bgView.wz_width/2, bgView.wz_height/2) ;
            [titleBtn setTitle:self.titleArr[index] forState:UIControlStateNormal];
            [titleBtn setTitleColor:FirstColor forState:UIControlStateNormal];
            [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            titleBtn.clipsToBounds = YES;
            titleBtn.layer.cornerRadius = titleBtn.wz_height/2;
            titleBtn.tag = 100 + index;
            if (index == 0) {
                titleBtn.selected = YES;
                titleBtn.clipsToBounds = YES;
                titleBtn.backgroundColor = ThemeColor;
                titleBtn.layer.cornerRadius = titleBtn.wz_height/2;
                self.selectBtn = titleBtn;
            }
//            weakify(self)
            typeof(self) weakSelf = self;
            [titleBtn bk_whenTapped:^{
//              strongify(self)
                titleBtn.backgroundColor = ThemeColor;
                weakSelf.selectBtn.backgroundColor = [UIColor whiteColor];
                weakSelf.selectBtn.selected = NO;
                weakSelf.selectBtn = titleBtn;
                weakSelf.selectBtn.selected = YES;
                
                [UIView animateWithDuration:0.1 animations:^{
                    weakSelf.indexView.wz_centerX = index * itemWidth + itemWidth/2;
                }];
                //回调
                if(weakSelf.headItemClickBlock){
                    weakSelf.headItemClickBlock(index);
                }
            }];
            [bgView addSubview:titleBtn];
            [self addSubview:bgView];
        }
        //sel
        self.indexView.center = CGPointMake(itemWidth/2, itemHeight - 1) ;
        [self addSubview:self.indexView];
        
    }else{
        self.wz_height = 0;
    }
    
}
-(UIView *)indexView{
    if (!_indexView) {
        _indexView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 2)];
        _indexView.backgroundColor = ThemeColor;
        
    }
    return _indexView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
