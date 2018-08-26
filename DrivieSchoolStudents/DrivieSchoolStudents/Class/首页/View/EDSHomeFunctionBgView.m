//
//  EDSHomeFunctionBgView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSHomeFunctionBgView.h"

#import "EDSHomeFunctionBtn.h"
#import "HomeConstants.h"

@interface EDSHomeFunctionBgView ()
@property (nonatomic , strong) NSMutableArray *btnMulArr;
@end

@implementation EDSHomeFunctionBgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = WhiteColor;
    }
    return self;
}

- (void)setFunctionBtnArr:(NSArray *)functionBtnArr
{
    _functionBtnArr = functionBtnArr;
    
    dispatch_apply(functionBtnArr.count, dispatch_get_global_queue(0, 0), ^(size_t i) {
        dispatch_async(dispatch_get_main_queue(), ^{
           
            NSInteger x = i / 4;
            NSInteger y = (i % 4);// 0 1 2 3
            CGFloat l = 0.33;
            if (y == 0 ) {
                l = 0.30;
            }else if (y == 1){
                l = 0.77 ;
            }else if (y == 2){
                l = 1.23;
            }else{
                l = 1.70;
            }
            
            EDSHomeFunctionBtn *btn = [[EDSHomeFunctionBtn alloc] init];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(50, 70));
                make.top.mas_equalTo(15 + (70 + 18)*x);
                make.centerX.multipliedBy(l);
//                make.centerY.centerX.mas_equalTo(0);
            }];
            btn.btnArr = functionBtnArr[i];
        });
    });
    
}

- (NSMutableArray *)btnMulArr
{
    if (!_btnMulArr) {
        
        for (int i = 0; i < 8; i ++) {
            
        }
    }
    return _btnMulArr;
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

@end
