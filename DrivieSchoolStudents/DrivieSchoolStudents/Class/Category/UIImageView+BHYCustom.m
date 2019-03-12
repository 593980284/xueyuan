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
@implementation NSDictionary (BHYCustom)
- (NSArray *)xx_allValues{
    if (!self) {
        return @[];
    }
    if (self.allKeys.count ==0) {
        return @[];
    }
    NSArray<NSString *>  *keys = self.allKeys;
    NSMutableArray<NSString *> *mutableArray = [keys mutableCopy];
    for (NSInteger i = 0; i < mutableArray.count; i++) {
        for (NSInteger j = 0; j < mutableArray.count - i - 1; j++) {
            NSString *s1 =mutableArray[j];
            NSString *s2 =mutableArray[j + 1];
            
            if ( [s1 compare:s2] == NSOrderedDescending) {
                NSString * tempFloat = mutableArray[j];
                mutableArray[j] = mutableArray[j + 1];
                mutableArray[j + 1] = tempFloat;
            }
        }
    }
    NSMutableArray *vlaues = [NSMutableArray new];
    for (int i = 0; i<mutableArray.count; i++) {
        [vlaues addObject:self[mutableArray[i]]];
    }
    return [vlaues copy];
}
@end
