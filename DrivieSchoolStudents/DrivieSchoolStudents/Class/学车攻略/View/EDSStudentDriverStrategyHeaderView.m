//
//  EDSStudentDriverStrategyHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentDriverStrategyHeaderView.h"
@interface EDSStudentDriverStrategyHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *testGaugeBtn;
@property (weak, nonatomic) IBOutlet UIButton *skillsBtn;
@property (weak, nonatomic) IBOutlet UIButton *funBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *indicatorViewCenterX;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@end

@implementation EDSStudentDriverStrategyHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    @weakify(self);
    self.testGaugeBtn.selected = YES;
    [self.testGaugeBtn bk_whenTapped:^{
        @strongify(self);
        self.testGaugeBtn.selected = YES;
        self.skillsBtn.selected = NO;
        self.funBtn.selected = NO;
        [self indicatorAnimationWithCenterX:self.testGaugeBtn.wz_centerX];
        if (self.viewDidSelectBtnBlock) {
            
            self.viewDidSelectBtnBlock(@"1");
        }
    }];
    [self.skillsBtn bk_whenTapped:^{
        @strongify(self);
        self.testGaugeBtn.selected = NO;
        self.skillsBtn.selected = YES;
        self.funBtn.selected = NO;
        [self indicatorAnimationWithCenterX:self.skillsBtn.wz_centerX];
        if (self.viewDidSelectBtnBlock) {
            
            self.viewDidSelectBtnBlock(@"2");
        }
    }];
    [self.funBtn bk_whenTapped:^{
        @strongify(self);
        self.testGaugeBtn.selected = NO;
        self.skillsBtn.selected = NO;
        self.funBtn.selected = YES;
        [self indicatorAnimationWithCenterX:self.funBtn.wz_centerX];
        if (self.viewDidSelectBtnBlock) {
            
            self.viewDidSelectBtnBlock(@"3");
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
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSStudentDriverStrategyHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSStudentDriverStrategyHeaderView" owner:self options:nil] lastObject];
        
    }
    return self;
}


@end
