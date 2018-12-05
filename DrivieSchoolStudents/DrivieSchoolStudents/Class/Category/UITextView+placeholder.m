//
//  UITextView+placeholder.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "UITextView+placeholder.h"

@implementation UITextView (placeholder)

- (void)setPlaceHolder:(NSString *)placeHolder {
    UILabel *placeHolderStr = [[UILabel alloc] init];
    placeHolderStr.text = placeHolder;
    placeHolderStr.numberOfLines = 0;
    placeHolderStr.textColor = [UIColor lightGrayColor];
    [placeHolderStr sizeToFit];
    [self addSubview:placeHolderStr];
    placeHolderStr.font = self.font;
    [self setValue:placeHolderStr forKey:@"_placeholderLabel"];
}

@end
