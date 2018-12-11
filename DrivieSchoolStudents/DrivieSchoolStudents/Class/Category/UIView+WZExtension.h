//
//  UIView+WZExtension.h
//  JianShiJia
//
//  Created by 卓森 on 2018/2/26.
//  Copyright © 2018年 卓森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WZExtension)

@property (nonatomic, assign) CGFloat   wz_x;
@property (nonatomic, assign) CGFloat   wz_y;
@property (nonatomic, assign) CGFloat   wz_centerX;
@property (nonatomic, assign) CGFloat   wz_centerY;
@property (nonatomic, assign) CGFloat   wz_width;
@property (nonatomic, assign) CGFloat   wz_height;
@property (nonatomic, assign) CGSize    wz_size;
@property (nonatomic, assign) CGPoint   wz_origin;
@property (nonatomic, assign) CGFloat   wz_bottom;
@property (nonatomic,assign) CGFloat    wz_right;

+ (instancetype)viewWithBackgroundColor:(UIColor *)color superView:(UIView *)superView;

@end
