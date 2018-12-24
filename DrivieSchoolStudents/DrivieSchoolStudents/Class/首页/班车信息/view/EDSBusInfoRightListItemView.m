//
//  EDSBusInfoRightListItemView.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/23.
//  Copyright © 2018 班文政. All rights reserved.
//

#define itemView_heigth 80
#define itemView_width 100


#import "EDSBusInfoRightListItemView.h"
@interface EDSBusInfoRightListItemView()

@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation EDSBusInfoRightListItemView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.dataArr=@[
                      @"6:00",
                      @"9:00",
                      @"11:00",
                      @"11:00"
                      ];
        [self initView];
    }
    return self;
}
-(void)initView{
    for (NSInteger Index = 0 ; Index < self.dataArr.count; Index++) {
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Index *itemView_width, 0, itemView_width, itemView_heigth)];
        timeLabel.font = [UIFont systemFontOfSize:14];
        timeLabel.text = self.dataArr[Index];
        [self addSubview:timeLabel];
    }
    
    self.wz_height = itemView_heigth;
    self.wz_width = self.dataArr.count * itemView_width;
}

@end
