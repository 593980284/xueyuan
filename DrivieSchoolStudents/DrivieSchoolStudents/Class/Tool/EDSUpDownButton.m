//
//  EDSUpDownButton.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/25.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSUpDownButton.h"

@implementation EDSUpDownButton

// 加载xib都会先走这个方法
- (void)awakeFromNib {
    [super awakeFromNib];
    // 可以在这里对button进行一些统一的设置
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 1;
}

// 在重新layout子控件时，改变图片和文字的位置
- (void)layoutSubviews {
    [super layoutSubviews];
    // 图片上限靠着button的顶部
    CGRect tempImageviewRect = self.imageView.frame;
    tempImageviewRect.origin.y = 10;
    // 图片左右居中，也就是x坐标为button宽度的一半减去图片的宽度
    tempImageviewRect.origin.x = (self.bounds.size.width - tempImageviewRect.size.width) / 2;
    self.imageView.frame = tempImageviewRect;
    CGRect tempLabelRect = self.titleLabel.frame;
    // 文字label的x靠着button左侧(或距离多少)
    tempLabelRect.origin.x = 20;
    // y靠着图片的下部
    tempLabelRect.origin.y = self.imageView.frame.size.height + 5;
    // 宽度与button一致，或者自己改
    tempLabelRect.size.width = self.bounds.size.width - 40;
    // 高度等于button高度减去上方图片高度
    tempLabelRect.size.height = self.bounds.size.height - self.imageView.frame.size.height;
    self.titleLabel.frame = tempLabelRect;
}

@end
