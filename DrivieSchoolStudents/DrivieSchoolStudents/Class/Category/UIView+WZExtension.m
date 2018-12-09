//
//  UIView+WZExtension.m
//  JianShiJia
//
//  Created by 卓森 on 2018/2/26.
//  Copyright © 2018年 卓森. All rights reserved.
//

#import "UIView+WZExtension.h"

@implementation UIView (WZExtension)


- (void)setWz_x:(CGFloat)wz_x
{
    CGRect frame = self.frame;
    frame.origin.x = wz_x;
    self.frame = frame;
}



- (void)setWz_y:(CGFloat)wz_y
{
    CGRect frame = self.frame;
    frame.origin.y = wz_y;
    self.frame = frame;
}


- (CGFloat)wz_x
{
    return self.frame.origin.x;
}


- (CGFloat)wz_y
{
    return self.frame.origin.y;
}


- (void)setWz_width:(CGFloat)wz_width
{
    CGRect frame = self.frame;
    frame.size.width = wz_width;
    self.frame = frame;
}

- (void)setWz_height:(CGFloat)wz_height
{
    CGRect frame = self.frame;
    frame.size.height = wz_height;
    self.frame = frame;
}


- (CGFloat)wz_height
{
    return self.frame.size.height;
}



- (void)setWz_bottom:(CGFloat)wz_bottom
{
    
}


- (CGFloat)wz_bottom
{
    //    return self.xmg_y + self.xmg_height;
    return CGRectGetMaxY(self.frame);
}


- (CGFloat)wz_width
{
    return self.frame.size.width;
}



- (void)setWz_centerX:(CGFloat)wz_centerX
{
    CGPoint center = self.center;
    center.x = wz_centerX;
    self.center = center;
}

- (CGFloat)wz_centerX
{
    return self.center.x;
}

- (void)setWz_centerY:(CGFloat)wz_centerY
{
    CGPoint center = self.center;
    center.y = wz_centerY;
    self.center = center;
}

- (CGFloat)wz_centerY
{
    return self.center.y;
}


- (void)setWz_size:(CGSize)wz_size
{
    CGRect frame = self.frame;
    frame.size = wz_size;
    self.frame = frame;
}

- (CGSize)wz_size
{
    return self.frame.size;
}
-(CGFloat)wz_right{
    return self.wz_x + self.wz_width;
}
- (void)setWz_origin:(CGPoint)wz_origin
{
    CGRect frame = self.frame;
    frame.origin = wz_origin;
    self.frame = frame;
}

- (CGPoint)wz_origin
{
    return self.frame.origin;
}

+ (instancetype)viewWithBackgroundColor:(UIColor *)color superView:(UIView *)superView
{
    UIView *wzView = [[UIView alloc] init];
    wzView.backgroundColor = color;
    [superView addSubview:wzView];
    return wzView;
}

@end
