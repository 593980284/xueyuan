//
//  UILabel+BHYCustom.h
//  HuanYouth
//
//  Created by 班文政 on 2018/6/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BHYCustom)

+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor backGroundColor:(UIColor *)backGroundColor superView:(UIView *)superView;

@end
