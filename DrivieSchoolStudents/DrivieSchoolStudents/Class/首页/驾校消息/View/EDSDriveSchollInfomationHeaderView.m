//
//  EDSDriveSchollInfomationHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSDriveSchollInfomationHeaderView.h"

@interface EDSDriveSchollInfomationHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UIButton *scoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *distanceBtn;
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;

@end

@implementation EDSDriveSchollInfomationHeaderView

- (void)setFirstBtnString:(NSString *)firstBtnString
{
    _firstBtnString = firstBtnString;
    
    if (firstBtnString.length > 0) {
        
        [self.scoreBtn setTitle:firstBtnString forState:UIControlStateNormal];
        [self.scoreBtn setTitle:firstBtnString forState:UIControlStateSelected];
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.scoreBtn.selected = YES;
    @weakify(self);
    [self.scoreBtn bk_whenTapped:^{
        @strongify(self);
        self.scoreBtn.selected = YES;
        self.distanceBtn.selected = NO;
        self.priceBtn.selected = NO;
        [self indicatorAnimationWithCenterX:self.scoreBtn.wz_centerX];
    }];
    
    [self.distanceBtn bk_whenTapped:^{
        @strongify(self);
        self.scoreBtn.selected = NO;
        self.distanceBtn.selected = YES;
        self.priceBtn.selected = NO;
        [self indicatorAnimationWithCenterX:self.distanceBtn.wz_centerX];
    }];
    
    [self.priceBtn bk_whenTapped:^{
        @strongify(self);
        self.scoreBtn.selected = NO;
        self.distanceBtn.selected = NO;
        self.priceBtn.selected = YES;
        [self indicatorAnimationWithCenterX:self.priceBtn.wz_centerX];
    }];
}

- (void)indicatorAnimationWithCenterX:(CGFloat)centerX
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.indicatorView.wz_centerX = centerX;
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSDriveSchollInfomationHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSDriveSchollInfomationHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}


@end
