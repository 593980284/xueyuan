//
//  EDSPSWLogoViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSPSWLogoViewController.h"

@interface EDSPSWLogoViewController ()

@property (weak, nonatomic) IBOutlet UIButton *pswBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;

@end

@implementation EDSPSWLogoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pswBtn.selected = YES;
    
    @weakify(self);
    [self.pswBtn bk_whenTapped:^{
        @strongify(self);
        self.pswBtn.selected = YES;
        self.codeBtn.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.indicatorView.wz_centerX = self.pswBtn.wz_centerX;
        }];
    }];
    [self.codeBtn bk_whenTapped:^{
        @strongify(self);
        self.pswBtn.selected = NO;
        self.codeBtn.selected = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.indicatorView.wz_centerX = self.codeBtn.wz_centerX;
        }];
    }];
}



@end
