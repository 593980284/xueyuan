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
        if (self.driveSchollInfomationHeaderViewDidSelectStringback) {
            
            self.driveSchollInfomationHeaderViewDidSelectStringback(@"0");
        }
    }];
    
    [self.distanceBtn bk_whenTapped:^{
        @strongify(self);
        self.scoreBtn.selected = NO;
        self.distanceBtn.selected = YES;
        self.priceBtn.selected = NO;
        [self indicatorAnimationWithCenterX:self.distanceBtn.wz_centerX];
        if (self.driveSchollInfomationHeaderViewDidSelectStringback) {
            
            self.driveSchollInfomationHeaderViewDidSelectStringback(@"1");
        }
    }];
    
    [self.priceBtn bk_whenTapped:^{
        @strongify(self);
        self.scoreBtn.selected = NO;
        self.distanceBtn.selected = NO;
        self.priceBtn.selected = YES;
        [self indicatorAnimationWithCenterX:self.priceBtn.wz_centerX];
        if (self.driveSchollInfomationHeaderViewDidSelectStringback) {
            
            self.driveSchollInfomationHeaderViewDidSelectStringback(@"2");
        }
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
