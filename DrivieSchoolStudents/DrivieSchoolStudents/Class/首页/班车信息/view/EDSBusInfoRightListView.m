//
//  EDSBusInfoRightListView.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/23.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSBusInfoRightListView.h"
#import "EDSBusInfoRightListItemView.h"

#define cellHeight  65
#define view_width  kScreenWidth - 100


@interface EDSBusInfoRightListView()

@property (nonatomic,strong)  UIScrollView * BgScro;

@property (nonatomic,assign) CGFloat max_width;



@end

@implementation EDSBusInfoRightListView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.wz_width = view_width;
        [self initView];
        
    }
    return self;
}

-(void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    [self initView];
}
-(void)initView{
    
    self.backgroundColor = [UIColor whiteColor];
    
    for (UIView *view in self.BgScro.subviews) {
        [view removeFromSuperview];
    }
    [self addSubview:self.BgScro];
    
    
    for (NSInteger index = 0 ; index < self.dataArr.count; index++) {
        EDSBusInfoRightListItemView * itemView = [[EDSBusInfoRightListItemView alloc]initWithFrame:CGRectMake(5, index *cellHeight, view_width, cellHeight)];
        NSString * tempTimeString =self.dataArr[index][@"arrivalTime"];
        itemView.dataArr = [tempTimeString componentsSeparatedByString:@","];
        [self.BgScro addSubview:itemView];
        if (itemView.wz_width > self.max_width) {
            self.max_width = itemView.wz_width;
        }
    }
    self.wz_height = self.dataArr.count * cellHeight;

//    self.wz_width = self.max_width;
    [self.BgScro setContentSize:CGSizeMake(self.max_width, 0)];
    self.BgScro.wz_height = self.wz_height;
}

-(UIScrollView *)BgScro{
    if (!_BgScro) {
        _BgScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, view_width, 0)];
//        _BgScro.backgroundColor = [UIColor redColor];
        
    }
    return _BgScro;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
