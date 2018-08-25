//
//  UIBarButtonItem+BHYCategory.m
//  HuanYouth
//
//  Created by 卓森 on 2018/6/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "UIBarButtonItem+BHYCategory.h"
#import "UIView+WZExtension.h"

@implementation UIBarButtonItem (BHYCategory)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.wz_size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
