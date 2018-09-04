//
//  EDSDrivingDetailsFooterView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSDrivingDetailsFooterView.h"

@interface EDSDrivingDetailsFooterView ()

@end

@implementation EDSDrivingDetailsFooterView
- (IBAction)toSignUpClick:(id)sender {
    DLog(@"前往报名");
    if (self.drivingDetailsFooterViewDidSelectStringback) {
        
        self.drivingDetailsFooterViewDidSelectStringback(@"前往报名");
    }
}
- (IBAction)consultingClick:(id)sender {
    DLog(@"咨询");
    if (self.drivingDetailsFooterViewDidSelectStringback) {
        
        self.drivingDetailsFooterViewDidSelectStringback(@"咨询");
    }
}
- (IBAction)priceShowClick:(id)sender {
    DLog(@"价格公示");
    if (self.drivingDetailsFooterViewDidSelectStringback) {
        
        self.drivingDetailsFooterViewDidSelectStringback(@"价格公示");
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSDrivingDetailsFooterView" owner:self options:nil] lastObject];
    }
    return self;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSDrivingDetailsFooterView" owner:self options:nil] lastObject];
    }
    return self;
}

@end
