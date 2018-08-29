//
//  EDSOnlineAboutClassDetailAppointmentHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineAboutClassDetailAppointmentHeaderView.h"

@implementation EDSOnlineAboutClassDetailAppointmentHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSOnlineAboutClassDetailAppointmentHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}


- (instancetype)init
{
    return [self initWithFrame:self.frame];
}


@end
