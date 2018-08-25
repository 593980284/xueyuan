//
//  UIImage+BHYAvatar.m
//  HuanYouth
//
//  Created by 卓森 on 2018/6/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "UIImage+BHYAvatar.h"

@implementation UIImage (BHYAvatar)

+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    UIImage *img = [UIImage imageNamed:name];
    //开启绘图上下文
    UIGraphicsBeginImageContext(img.size);
    CGPoint center = CGPointMake(img.size.width * 0.5, img.size.height * 0.5);
    CGFloat radius = MIN(center.x, center.y);
    //先画一个白色的圆
    UIBezierPath *bgPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [[UIColor whiteColor] setFill];
    [bgPath fill];
    
    //再画一个小一点的圆
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius - 10 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //设置剪裁区域
    [path addClip];
    [img drawAtPoint:CGPointZero];
    
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}
@end
