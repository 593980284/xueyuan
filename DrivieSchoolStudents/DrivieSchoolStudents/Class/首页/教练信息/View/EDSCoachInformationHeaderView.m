//
//  EDSCoachInformationHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCoachInformationHeaderView.h"

@implementation EDSCoachInformationHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSCoachInformationHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}


- (instancetype)init
{
    return [self initWithFrame:self.frame];
}
@end
