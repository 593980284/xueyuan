//
//  UIView+BHYAbovePictureBelowText.h
//  HuanYouth
//
//  Created by 卓森 on 2018/6/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BHYAbovePictureBelowText)
+ (UIView *)initWithImage:(UIImage *)img text:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)textFont pictureWithTextSpacing:(CGFloat)spacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;
@end
