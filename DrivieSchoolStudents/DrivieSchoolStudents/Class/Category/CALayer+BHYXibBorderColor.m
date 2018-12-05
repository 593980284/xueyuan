//
//  CALayer+BHYXibBorderColor.m
//  HuanYouth
//
//  Created by 卓森 on 2018/8/9.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "CALayer+BHYXibBorderColor.h"
#import <UIKit/UIKit.h>

@implementation CALayer (BHYXibBorderColor)

- (void)setBorderColorWithUIColor:(UIColor *)color
{
    
    self.borderColor = color.CGColor;
}

@end
