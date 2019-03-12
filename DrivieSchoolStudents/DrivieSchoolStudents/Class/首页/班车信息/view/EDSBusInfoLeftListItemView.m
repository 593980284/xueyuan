//
//  EDSBusInfoLeftListItemView.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/23.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSBusInfoLeftListItemView.h"
#define selfHeight 65
@interface EDSBusInfoLeftListItemView()
@property (nonatomic,strong) UILabel *nameLabel;

@end

@implementation EDSBusInfoLeftListItemView


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:(CGRect)frame]){
        [self initView];
    }
    return self;
}
-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
   //   self.nameLabel. adjustsFontSizeToFitWidth = YES;
    self.nameLabel.text = dataDic[@"station"];
}
-(void)initView{
    UIView *leftLine = [[UIView alloc]initWithFrame:CGRectMake(5, 0, 1, selfHeight)];
    leftLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:leftLine];
    
    UIView *cirView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
    cirView.clipsToBounds = YES;
    cirView.layer.cornerRadius = 2.5;
    cirView.backgroundColor = [UIColor grayColor];
    cirView.center = CGPointMake(5, selfHeight/2);
    [self addSubview:cirView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftLine.wz_right + 10, (selfHeight - 80)/2, 70, 80)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = @"";
    nameLabel.font = [UIFont systemFontOfSize:12];
    nameLabel.numberOfLines = 0;
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
