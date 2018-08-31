//
//  EDSCourseRecordDetailHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/31.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordDetailHeaderView.h"

@implementation EDSCourseRecordDetailHeaderView

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSCourseRecordDetailHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}
@end
