//
//  UIView+BHYAbovePictureBelowText.m
//  HuanYouth
//
//  Created by 卓森 on 2018/6/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "UIView+BHYAbovePictureBelowText.h"

@implementation UIView (BHYAbovePictureBelowText)
+ (UIView *)initWithImage:(UIImage *)img text:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)textFont pictureWithTextSpacing:(CGFloat)spacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing
{
    UIView *bgView = [[UIView alloc] init];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = img;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
//    imgView.layer.masksToBounds = YES;
    [bgView addSubview:imgView];
    
    UILabel *label = [UILabel labelWithText:text font:textFont textColor:textColor backGroundColor:ClearColor superView:bgView];
    
    NSArray *viewsArr = @[imgView ,label];
    
    [viewsArr mas_distributeViewsAlongAxis:MASAxisTypeVertical
                          withFixedSpacing:spacing
                               leadSpacing:leadSpacing
                               tailSpacing:tailSpacing];
    [viewsArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
    }];
    
    return bgView;
}
@end
