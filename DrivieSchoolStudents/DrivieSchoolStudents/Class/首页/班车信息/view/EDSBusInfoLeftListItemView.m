//
//  EDSBusInfoLeftListItemView.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/23.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSBusInfoLeftListItemView.h"
@interface EDSBusInfoLeftListItemView()

@end

@implementation EDSBusInfoLeftListItemView


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:(CGRect)frame]){
        [self initView];
    }
    return self;
}
-(void)initView{
    UIView *leftLine = [[UIView alloc]initWithFrame:CGRectMake(5, 0, 1, 80)];
    leftLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:leftLine];
    
    UIView *cirView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 3, 3)];
    cirView.clipsToBounds = YES;
    cirView.layer.cornerRadius = 1.5;
    cirView.backgroundColor = [UIColor grayColor];
    cirView.center = CGPointMake(5, 40);
    [self addSubview:cirView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftLine.wz_right + 10, 30, 50, 20)];
    nameLabel.text = @"北京";
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:nameLabel];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
