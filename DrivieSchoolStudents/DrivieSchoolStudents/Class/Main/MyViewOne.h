//
//  MyViewOne.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MyViewOne : UIView
@property (strong, nonatomic) NSMutableArray *btns;
@property (strong, nonatomic) NSMutableArray *data;
- (instancetype)initWithData:(NSArray *)data;
@property(nonatomic, copy)void(^btnTapBlock)(NSString *name, NSString *code);
@property(nonatomic, copy)void(^missBlock)();
@end


