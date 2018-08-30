//
//  EDSCourseRecordHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordHeaderView.h"

@interface EDSCourseRecordHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIButton *unfinishBtn;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@end

@implementation EDSCourseRecordHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.finishBtn.selected = YES;
    
    
    @weakify(self);
    [self.finishBtn bk_whenTapped:^{
        @strongify(self);
        self.finishBtn.selected = YES;
        self.unfinishBtn.selected = NO;
        [self indicatorAnimationWithCenterX:self.finishBtn.wz_centerX];
    }];
    
    [self.unfinishBtn bk_whenTapped:^{
        @strongify(self);
        self.finishBtn.selected = NO;
        self.unfinishBtn.selected = YES;
        [self indicatorAnimationWithCenterX:self.unfinishBtn.wz_centerX];
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
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSCourseRecordHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

@end
