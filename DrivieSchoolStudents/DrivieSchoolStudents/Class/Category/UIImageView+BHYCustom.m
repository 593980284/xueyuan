//
//  UIImageView+BHYCustom.m
//  HuanYouth
//
//  Created by 卓森 on 2018/7/4.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "UIImageView+BHYCustom.h"

@implementation UIImageView (BHYCustom)

+ (instancetype)imageViewWithSuperView:(UIView *)superView
{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.layer.masksToBounds = YES;
    [superView addSubview:imgView];
    return imgView;
}
@end
