//
//  MyButton2.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "MyButton2.h"

@implementation MyButton2

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"gou"] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:@""] forState:0];
        [self setTitleColor:[UIColor colorWithRed:90/255.0 green:160/255.0 blue:250/255.6 alpha:1] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:0];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (void)layoutSubviews
{    [super layoutSubviews];
    CGRect imageRect = self.imageView.frame;
    imageRect.size = CGSizeMake(10, 10);
    CGRect titleRect = self.titleLabel.frame;
    imageRect.origin.x = self.frame.size.width  - 10 -20;
    imageRect.origin.y = (self.frame.size.height  - 10)/2.0f;
    titleRect.origin.x = 20;
    titleRect.origin.y = (self.frame.size.height - titleRect.size.height)/2.0f;
    self.imageView.frame = imageRect;    self.titleLabel.frame = titleRect;
}


@end
