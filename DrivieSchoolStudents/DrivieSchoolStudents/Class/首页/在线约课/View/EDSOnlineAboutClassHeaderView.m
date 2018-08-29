//
//  EDSOnlineAboutClassHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineAboutClassHeaderView.h"

@interface EDSOnlineAboutClassHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@end

@implementation EDSOnlineAboutClassHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.button1.selected = YES;
    @weakify(self);
    [self.button1 bk_whenTapped:^{
        @strongify(self);
        self.button1.selected = YES;
        self.button2.selected = NO;
        self.button3.selected = NO;
        [self indicatorAnimationWithCenterX:self.button1.wz_centerX];
    }];
    
    [self.button2 bk_whenTapped:^{
        @strongify(self);
        self.button1.selected = NO;
        self.button2.selected = YES;
        self.button3.selected = NO;
        [self indicatorAnimationWithCenterX:self.button2.wz_centerX];
    }];
    
    [self.button3 bk_whenTapped:^{
        @strongify(self);
        self.button1.selected = NO;
        self.button2.selected = NO;
        self.button3.selected = YES;
        [self indicatorAnimationWithCenterX:self.button3.wz_centerX];
    }];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSOnlineAboutClassHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSOnlineAboutClassHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}

- (void)indicatorAnimationWithCenterX:(CGFloat)centerX
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.indicatorView.wz_centerX = centerX;
    }];
}
@end
