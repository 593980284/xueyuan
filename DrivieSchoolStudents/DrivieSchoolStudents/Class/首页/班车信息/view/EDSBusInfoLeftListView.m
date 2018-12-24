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

@property (nonatomic,strong) NSArray *dataArr;


@end

@implementation EDSBusInfoLeftListView


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:(CGRect)frame]){
        self.dataArr = @[
                         @"北京",
                         @"北京",
                         @"北京",
                         @"北京",
                         @"北京",
                         @"北京",
                         @"北京",
                         @"北京",
                         @"北京",
                         @"北京",
                         @"北京",
                         @"北京",
                         @"北京",
                         @"北京",
                         ];
        [self initView];
    }
    return self;
}
-(void)initView{
    self.backgroundColor = [UIColor whiteColor];
    CGFloat item_y = 0;
    CGFloat item_x = 0;
    CGFloat item_width = 100;
    CGFloat item_heigth = 80;
    for (NSInteger index = 0; index < self.dataArr.count; index++) {
        EDSBusInfoLeftListItemView * itemView = [[EDSBusInfoLeftListItemView alloc]initWithFrame:CGRectMake(item_x, item_heigth * index, item_width, item_heigth)];
        [self addSubview:itemView];
    }
    self.wz_height = self.dataArr.count * item_heigth;
}


@end
