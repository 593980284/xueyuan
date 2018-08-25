//
//  UIBarButtonItem+BHYCategory.h
//  HuanYouth
//
//  Created by 卓森 on 2018/6/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BHYCategory)

/**
 创建一个图片item
 
 @param target 点击item后调用哪个对象的方法
 @param action 点击item后调用target的哪个方法
 @param image 图片
 @param highImage 高亮的图片
 @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
