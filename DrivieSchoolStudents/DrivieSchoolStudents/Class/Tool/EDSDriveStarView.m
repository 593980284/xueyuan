//
//  EDSDriveStarView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSDriveStarView.h"

@interface EDSDriveStarView ()

@end

@implementation EDSDriveStarView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup{
    
    CGFloat W = self.frame.size.height;
    
    dispatch_apply(5, dispatch_get_global_queue(0, 0), ^(size_t i) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImageView *starImgView = [UIImageView imageViewWithSuperView:self];
            [starImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(W, W));
                make.centerY.mas_equalTo(0);
                make.left.mas_equalTo(20*i);
            }];
            
            if (i < self.selectNumber) {
                starImgView.image = [UIImage imageNamed:@"star_content_icon_selected"];
            }else{
                
                starImgView.image = [UIImage imageNamed:@"star_content_icon_default"];
            }
        });
    });
}

- (void)setSelectNumber:(NSInteger)selectNumber
{
    _selectNumber = selectNumber;
}
@end
