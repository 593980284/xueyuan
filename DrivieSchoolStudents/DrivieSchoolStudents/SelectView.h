//
//  SelectView.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectViewBtn : UIButton
@property (nonatomic , strong) UIColor *selectColor;
@property (nonatomic , strong) UIColor *nomalColor;
@property (nonatomic , strong) UIImageView *lineLb;
@property (nonatomic , strong) UIImageView *bgView;
@end
NS_ASSUME_NONNULL_BEGIN

@interface SelectView : UIView
-(instancetype)initWithData:(NSArray *)data;
@property(nonatomic, strong)NSArray *data;
@property(nonatomic, strong)NSMutableArray<SelectViewBtn *> *btns;
@property (nonatomic, copy) void (^block)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
