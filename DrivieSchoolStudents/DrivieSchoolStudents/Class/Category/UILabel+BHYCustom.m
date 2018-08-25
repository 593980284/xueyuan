//
//  UILabel+BHYCustom.m
//  HuanYouth
//
//  Created by 班文政 on 2018/6/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "UILabel+BHYCustom.h"

@implementation UILabel (BHYCustom)

+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor backGroundColor:(UIColor *)backGroundColor superView:(UIView *)superView
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = textColor;
    label.backgroundColor = backGroundColor;
    label.font = font;
    label.text = text;
    [superView addSubview:label];
    label.numberOfLines = 0;
    return label;
}
@end
