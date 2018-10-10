//
//  UIColor+LXColor.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LXColor)

/**
 通过16进制色值和透明度设置色值
 
 @param color #000000 0X000000 0x000000
 @param alpha 0.5
 @return UIColor
 */
+ (UIColor *)lx_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


@end
