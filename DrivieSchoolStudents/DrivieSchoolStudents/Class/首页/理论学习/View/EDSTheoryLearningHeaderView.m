//
//  EDSTheoryLearningHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSTheoryLearningHeaderView.h"

@interface EDSTheoryLearningHeaderView ()
{
    UIButton *_selectBtn;
}
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@end

@implementation EDSTheoryLearningHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.button1.selected = YES;
    _selectBtn = self.button1;
    
    @weakify(self);
    [self.button1 bk_whenTapped:^{
        @strongify(self);
        self->_selectBtn.selected = NO;
        self.button1.selected = YES;
        self->_selectBtn = self.button1;
        [self indicatorAnimationWithCenterX:self.button1.wz_centerX];
        if (self.headerDidSelectBtn) {
            
            self.headerDidSelectBtn(self.button1.titleLabel.text);
        }
    }];
    
    [self.button2 bk_whenTapped:^{
        @strongify(self);
        self->_selectBtn.selected = NO;
        self.button2.selected = YES;
        self->_selectBtn = self.button2;
        [self indicatorAnimationWithCenterX:self.button2.wz_centerX];
        if (self.headerDidSelectBtn) {
            
            self.headerDidSelectBtn(self.button2.titleLabel.text);
        }
    }];
    
    [self.button3 bk_whenTapped:^{
        @strongify(self);
        self->_selectBtn.selected = NO;
        self.button3.selected = YES;
        self->_selectBtn = self.button3;
        [self indicatorAnimationWithCenterX:self.button3.wz_centerX];
        if (self.headerDidSelectBtn) {
            
            self.headerDidSelectBtn(self.button3.titleLabel.text);
        }
    }];
    
    [self.button4 bk_whenTapped:^{
        @strongify(self);
        self->_selectBtn.selected = NO;
        self.button4.selected = YES;
        self->_selectBtn = self.button4;
        [self indicatorAnimationWithCenterX:self.button4.wz_centerX];
        if (self.headerDidSelectBtn) {
            
            self.headerDidSelectBtn(self.button4.titleLabel.text);
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
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSTheoryLearningHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

@end
