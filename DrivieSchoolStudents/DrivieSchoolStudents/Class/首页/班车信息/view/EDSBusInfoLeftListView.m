//
//  EDSBusInfoLeftListView.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/23.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSBusInfoLeftListView.h"
#import "EDSBusInfoLeftListItemView.h"

@interface EDSBusInfoLeftListView()




@end

@implementation EDSBusInfoLeftListView


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:(CGRect)frame]){
//        [self initView];
    }
    return self;
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    [self initView];
}
-(void)initView{
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    self.backgroundColor = [UIColor whiteColor];
    CGFloat item_y = 0;
    CGFloat item_x = 0;
    CGFloat item_width = 100;
    CGFloat item_heigth = 65;
    for (NSInteger index = 0; index < self.dataArr.count; index++) {
        EDSBusInfoLeftListItemView * itemView = [[EDSBusInfoLeftListItemView alloc]initWithFrame:CGRectMake(item_x, item_heigth * index, item_width, item_heigth)];
        itemView.dataDic = self.dataArr[index];
        [self addSubview:itemView];
    }
    self.wz_height = self.dataArr.count * item_heigth;
}


@end
